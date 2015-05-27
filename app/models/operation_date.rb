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

class OperationDate < ActiveRecord::Base
  belongs_to :bus
  belongs_to :bus_route
end
