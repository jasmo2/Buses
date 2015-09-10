# == Schema Information
#
# Table name: buses
#
#  id            :integer          not null, primary key
#  plate_license :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

class Bus < ActiveRecord::Base
  attr_accessor :driver_name
  belongs_to :user
  has_many :operation_dates
  has_many :bus_routes, through: :operation_dates
  validates :id, presence: true
  validates :plate_license, presence: true, format: { with: /^[a-zA-Z]{3}\d{3}$/ }
  validates :id, numericality: { only_integer: true }
  

  def self.update_multiple(id,buses_assignment,buses)
    buses.each_with_index do |bus_id,index|
      bus = find(bus_id) if bus_id != "nil"
      idd = if buses_assignment[index] == "nil" then nil else id end      
      bus.update(user_id: idd)
    end
  end

  def self.add_routes(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    header[1] = "plate_license"
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      bus = where(plate_license: row[1]).take
      raise ArgumentError, "Autobuses y placas no concuerdan" if bus.nil?
      for index in (2...row.count)
        if !row[index].nil? && !row[index].empty?
          bus_route = BusRoute.where(name: row[index]).take
          raise ArgumentError, "La ruta '#{row[index]}' no ah sido creada" if bus_route.nil?
          working_day = OperationDate.where(bus_route_id: bus_route.id, operation_date: header[index]).take unless bus_route.nil?
          if working_day.nil?
            unless OperationDate.create(bus_route_id: bus_route.id, operation_date: header[index], bus_id: bus.id )
              raise ArgumentError, "Error en la transacción"
            end
          else
            working_day.bus_id = bus.id
            unless working_day.save
              raise ArgumentError, "Error en la transacción"
            end
          end
        end
      end
    end
  end

  private
  before_validation(on: :create) do
    self.plate_license = plate_license.split.join if attribute_present?("plate_license")
  end
  def self.open_spreadsheet(file)
    if file != nil
      case File.extname(file.original_filename)
        when ".csv" then Roo::Csv.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise ArgumentError, "Tipo de Archivo desconocido #{file.original_filename}"
      end
    else
     raise ArgumentError, "Tipo de Archivo vacio"
    end
  end
end
