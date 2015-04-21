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

class Bus < ActiveRecord::Base
  belongs_to :user
  has_many :trips, :class_name => "object", :foreign_key => "reference_id"  
end
