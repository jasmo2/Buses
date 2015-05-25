# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  direction      :integer
#  operation_date :date
#  bus_id         :integer
#  bus_route_id   :integer
#  neighbourhood  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_time     :time
#  trip_column    :integer
#
# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
Trip.destroy_all
directions = Trip.directions.keys
buses = Bus.all
bus_routes = BusRoute.all
bus_routes.each do |bus_route|
  trips_quantity = rand(5)
  trips_quantity.times do |index|
    Trip.create(
      direction: directions[rand(2)], 
      trip_column: index, 
      neighbourhood: Faker::Address.city,
      bus_route_id: bus_route.id,
      start_time: rand(18060.. 86340).seconds,
      operation_date: (Faker::Time.forward(3).to_date).to_date
      )
  end
end
buses.each do |bus|  

end

