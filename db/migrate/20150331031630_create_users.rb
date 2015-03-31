class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :user,              null: false, default: "default_user"
			t.timestamps null: false
		end
	end
end
