# == Schema Information
#
# Table name: trips
#
#  id            :integer          not null, primary key
#  direction     :integer
#  bus_route_id  :integer
#  neighbourhood :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  start_time    :time
#  trip_column   :integer
#

require 'rails_helper'

RSpec.describe Trip, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
