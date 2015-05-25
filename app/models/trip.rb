# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  direction      :integer
#  operation_date :date
#  bus_id         :integer
#  bus_route_id   :integer
#  neighbourhood  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_time     :time
#  trip_column    :integer
#

class Trip < ActiveRecord::Base
  belongs_to :bus
  belongs_to :bus_route
  has_many :records
  enum direction: [:left,:right]
  validates :start_time, numericality: true
  after_validation :change_to_date

  def self.where_multiple(trips_data, *search_fields)
    trips = []
    trips_data.each do |trip_data|
    search_field = Hash.new
      search_fields.each do |field|  
        search_field[field] = trip_data[field] 
      end
      trips << where(search_field)[0]
    end
    return trips
  end
  def self.update_multiple(trips_data, multiple_trips)
    update_multiple_transaction = true
    transaction do 
      trips_data.each_with_index do |trip_data,index|  
        unless multiple_trips[index].update(trip_data)
          update_multiple_transaction = false
        end
      end
    end
    update_multiple_transaction
  end
  private
  def change_to_date
    if self.start_time != nil
      self.start_time = Time.gm(2000,01,01).utc + self.start_time.seconds
    end
  end
end
