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
#

class OperationDate < ActiveRecord::Base
end
