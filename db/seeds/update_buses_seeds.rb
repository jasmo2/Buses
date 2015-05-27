# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
readers_users = User.where(role: 2)

(1..30).each do |index|
  reader = readers_users[rand(readers_users.count)]
  bus = Bus.find(index)
  bus.update(user_id: reader.id)
end

