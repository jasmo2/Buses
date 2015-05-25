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
#

require 'rails_helper'

RSpec.describe Record, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
