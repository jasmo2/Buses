# == Schema Information
#
# Table name: records
#
#  id            :integer          not null, primary key
#  time          :time
#  quantity      :integer
#  register_type :integer
#  user_id       :integer          not null
#  trip_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Record < ActiveRecord::Base
  enum register_type: [:terminal, :control]
  
end
