class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.time :time
      t.integer :quantity
      t.integer :register_type
      t.integer :user_id ,null: false
      t.integer :trip_id ,null: false
      
      t.timestamps null: false
    end
    add_index :records, :user_id, :unique => true
    add_index :records, :trip_id, :unique => true
  end
end
