# == Schema Information
#
# Table name: records
#
#  id            :integer          not null, primary key
#  time          :time
#  quantity      :integer
#  register_type :integer
#  user_id       :integer          not null
#  trip_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Record < ActiveRecord::Base
  belongs_to :trip
  validates :quantity, presence: true
  validates :user_id, presence: true
  validates :bus_id, presence: true
  validate :bus_transit_this_day
  attr_accessor :bus_id
  enum register_type: [:terminal, :control]
  before_save :register_type_N_time ,:get_trip

  private
  def bus_transit_this_day
    errors.add(:En_programación, "el autobús no parece estar agendado.") unless Trip.exists?(self.trip_id)
  end
  def get_trip
    trip = Trip.where(bus_id: self.bus_id, operation_date:  Time.now.in_time_zone(-5).to_date).take
    self.trip_id = trip != nil ? trip.id : nil 
  end
  def register_type_N_time
   self.time = Time.zone.now()
  end
end
