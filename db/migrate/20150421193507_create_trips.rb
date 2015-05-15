class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :direction
      t.date :operation_date, null:false
      t.integer :bus_id
      t.integer :bus_routes_id
      t.string :neighbourhood
      t.timestamps null: false
    end
  end
end
