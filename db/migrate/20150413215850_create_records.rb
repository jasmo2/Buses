class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.time :time
      t.integer :quantity
      t.integer :register_type

      t.timestamps null: false
    end
  end
end
