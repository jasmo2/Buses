class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :direction
      t.time :star_time, null:false
      t.string :neighbourhood
      t.timestamps null: false
    end
  end
end
