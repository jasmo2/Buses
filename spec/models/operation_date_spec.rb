# == Schema Information
#
# Table name: operation_dates
#
#  id             :integer          not null, primary key
#  operation_date :date
#  bus_id         :integer
#  bus_route_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  terminal       :boolean          default(TRUE)
#  trip_column    :integer          default(0)
#

require 'rails_helper'

RSpec.describe OperationDate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
