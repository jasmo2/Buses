class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
      t.string :username,              null: false, default: ""
			t.integer :role
			t.timestamps null: false
		end
	end
end
