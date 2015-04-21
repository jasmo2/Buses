# == Schema Information
#
# Table name: bus_routes
#
#  id         :integer          not null, primary key
#  name       :string
#  trip_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BusRoute < ActiveRecord::Base
  has_many :trips
end
