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

require 'rails_helper'

RSpec.describe BusRoute, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
