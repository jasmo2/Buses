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
Trip.update_all(operation_date: Time.now.in_time_zone(-5).to_date)

