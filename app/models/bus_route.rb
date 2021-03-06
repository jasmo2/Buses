# == Schema Information
#
# Table name: bus_routes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BusRoute < ActiveRecord::Base
  has_many :trips
  has_many :operation_dates
  has_many :buses, through: :operation_dates

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    headers = ["direction","start_time","neighbourhood","bus_route_id","trip_column"]
    (3..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      @bus_route = where(name: row[0])
      if @bus_route.empty?
        @bus_route = create(name: row[0])
        trips_data = trips_hashing(
          headers,direction_conversion(
            row.drop(1).each_slice(3).to_a
            )
          )
        Trip.create(trips_data)
      else
        @bus_route = @bus_route.first 
        trips_data = trips_hashing(
          headers,direction_conversion(
            row.drop(1).each_slice(3).to_a
            )
          )
        multiple_trips = Trip.where_multiple(trips_data,"trip_column","bus_route_id")
        unless Trip.update_multiple(trips_data,multiple_trips)
          raise ArgumentError, "No se ha podido actulizar los datos"
        end
      end
    end
  end

  private
  def self.direction_conversion(trips_data)
    trips_data.each do |trip_data|
      if trip_data[0] != nil
        case trip_data[0].upcase
          when "D"
            trip_data[0] = "right"
          when "DERECHA"
            trip_data[0] = "right"
          when "I"
            trip_data[0] = "left"
          when "IZQUIERDA"
            trip_data[0] = "left"
          when ""
            trip_data[0] = ""
          else
            raise ArgumentError, "'#{trip_data[0]}' no es una dirección valida."
        end
      end
    end
  end
  def self.trips_hashing(headers,trips_data)
    trip_column = 0
    # eliminates all nil
    trips_data.each &:compact!
    # eliminates empty arrays
    trips_data.reject! { |c| c.empty? }
    trips_data.map! do |trip_data|
      trip_data << @bus_route.id
      trip_data << trip_column
      trip_column += 1
      Hash[[headers, trip_data].transpose].delete_if { |key, value| value.blank? }
    end

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
