# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
editors_users = User.where(role: 1)
Bus.destroy_all
(1..30).each do |index|
  editor = editors_users[rand(editors_users.count)]
  Bus.create(id: index, user_id: editor.id, plate_license: "#{(0...3).map { ('A'..'Z').to_a[rand(26)] }.join}#{rand(100..999)}" )
end

