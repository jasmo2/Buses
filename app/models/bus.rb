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
  has_many :trips
  has_many :bus_routes, through: :trips
  has_many :records, through: :trips
  validates :id, presence: true
  validates :plate_license, presence: true
  validates :id, numericality: { only_integer: true }
  

  def self.update_multiple(id,buses_assignment,buses)
    buses.each_with_index do |bus_id,index|
      bus = find(bus_id) if bus_id != "nil"
      idd = if buses_assignment[index] == "nil" then nil else id end      
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "bus tp #{bus}"
      puts "idd #{idd}"
      bus.update(user_id: idd)
    end
  end

  def self.add_routes(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    header[1] = "plate_license"
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      bus = where(plate_license: row[1])
      raise ArgumentError, "Autobuses y placas no concuerdan" if bus.empty?
      for index in (2...row.count)
        bus_route = BusRoute.where(name: row[index])[0]
        byebug
        trips_data = bus_route.trips
        multiple_trips = Trip.where_multiple(trips_data,"bus_id")
        unless Trip.update_multiple(trips_data,multiple_trips)
          raise ArgumentError, "No se ha podido actulizar los datos"
        end
      end
    end
  end

  private
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
