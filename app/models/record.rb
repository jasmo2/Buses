# == Schema Information
#
# Table name: records
#
#  id            :integer          not null, primary key
#  time          :time
#  quantity      :integer
#  register_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Record < ActiveRecord::Base
end
