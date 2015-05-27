# == Schema Information
#
# Table name: records
#
#  id            :integer          not null, primary key
#  register_time :time
#  quantity      :integer
#  register_type :integer
#  user_id       :integer          not null
#  bus_id        :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  register_date :date
#

class Record < ActiveRecord::Base
  belongs_to :bus
  validates :quantity, presence: true
  validates :user_id, presence: true
  validates :bus_id, presence: true
  enum register_type: [:terminal, :control]
  before_validation :get_checkpoint, :register_type_N_time, :register_type_N_date

  def self.filter_by_bus(bus_id,date)
    records  = where(bus_id: bus_id, register_date: date)
  end

  private

  def get_trip
    if self.terminal?
      working_day = OperationDate.where(operation_date: Time.now.in_time_zone(-5).to_date).take
      working_day.trip_column += 1
      working_day.save!
    end
    # BusRoute.where(bus_id: self.bus_id, operation_date:  Time.now.in_time_zone(-5).to_date).take
    # trip = Trip.where(bus_id: self.bus_id, operation_date:  Time.now.in_time_zone(-5).to_date).take
    self.trip_id = if trip != nil then trip.id else nil end
  end
  def register_type_N_time
    if self.register_time == nil
      self.register_time = Time.now.in_time_zone(-5)
    end
  end
  def register_type_N_date
    if self.register_date == nil
      self.register_date = Date.today(-5)
    end
  end
end
