# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  direction      :integer
#  operation_date :date
#  bus_id         :integer
#  bus_routes_id  :integer
#  neighbourhood  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_time     :time
#

class Trip < ActiveRecord::Base
  belongs_to :bus
  belongs_to :bus_route
  has_many :records
  enum direction: [:left,:right]
  validates :start_time, numericality: true
  after_validation :change_to_date

  private
  def change_to_date
    if self.start_time != nil
      self.start_time = Time.at(self.start_time).utc.strftime("%H:%M")
    end
  end
end
