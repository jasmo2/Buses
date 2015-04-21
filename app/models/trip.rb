class Trip < ActiveRecord::Base
  belongs_to :bus
  belongs_to :bus_route
  has_many :records
  enum direction: [:left,:right]

end
