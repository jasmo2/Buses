# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
(1..30).each do |index| 
  BusRoute.create(name: "A#{index}" )
end