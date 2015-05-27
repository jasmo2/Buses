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
#  register_date :date
#
# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end
Record.destroy_all
register_types = Record.register_types.keys
editor_users = User.where(role: 1)
trips = Trip.all
quantity1 = rand(100...200)

trips.each do |trip|
  busID = Bus.pluck(:id)
  quantity1 += rand(100...200) 
  user1_3 = editor_users[rand(editor_users.count)]
  begin
    user2 = editor_users[rand(editor_users.count)]
  end until user1_3 != user2
  record_time = Faker::Time.forward(3).in_time_zone(-5)
  # Initial - End ,Excepcet for the first one
  rnd_date_time = time_rand Time.local(2015, 5, 1), Time.local(2015, 5, 31)
  Record.new(
    register_type: :terminal,
    quantity: quantity1,
    user_id: user1_3.id,
    register_time: record_time,
    bus_id: busID[rand(busID.length-1)]
    ).save(validate:false)
  # Control
  quantity1 += rand(100...200) 
  Record.new(
    register_type: :control,
    quantity: quantity1,
    user_id: user2.id,
    register_time: record_time + 3600.seconds,
    bus_id: busID[rand(busID.length-1)]
    ).save(validate:false)
  # End
=begin

  Record.new(
    register_type: :terminal,
    quantity: quantity3,
    user_id: user1_3.id,
    register_time: record_time + 7200.seconds,
    trip_id: tripID
    ).save(validate:false)
=end
end

