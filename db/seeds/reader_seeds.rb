# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
(1..3).each do |index| 
  User.create(username: "reader-#{index}", role: :reader, password: "santiago", email: Faker::Internet.email )
end