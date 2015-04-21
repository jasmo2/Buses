# == Schema Information
#
# Table name: buses
#
#  id            :integer          not null, primary key
#  create        :string
#  update        :string
#  plate_license :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Bus, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
