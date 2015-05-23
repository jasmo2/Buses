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
# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
Record.destroy_all
register_types = Record.register_types.keys
editor_users = User.where(role: 1)
trips = Trip.all
trips.each do |trip|
  busID = trip.bus.id
  quantity1 = rand(100...200) 
  quantity2 = rand(quantity1...400) 
  quantity3 = rand(quantity2...600) 
  user1_3 = editor_users[rand(editor_users.count)]
  begin
    user2 = editor_users[rand(editor_users.count)]
  end until user1_3 != user2
  record_time = Faker::Time.forward(3).in_time_zone(-5)
  # Initial
  Record.create(
    register_type: :terminal,
    quantity: quantity1,
    user_id: user1_3.id,
    register_time: record_time,
    bus_id: busID
    )
  # Control
  Record.create(
    register_type: :control,
    quantity: quantity2,
    user_id: user2.id,
    register_time: record_time + 3600.seconds,
    bus_id: busID
    )
  # End
  Record.create(
    register_type: :terminal,
    quantity: quantity3,
    user_id: user1_3.id,
    register_time: record_time + 7200.seconds,
    bus_id: busID
    )
end

