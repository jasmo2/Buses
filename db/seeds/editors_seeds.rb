# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
(1..3).each do |index| 
  User.create(username: "editor-#{index}", role: :editor, password: "santiago", email: Faker::Internet.email )
end