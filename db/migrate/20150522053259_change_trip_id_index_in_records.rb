class ChangeTripIdIndexInRecords < ActiveRecord::Migration
  def change
    remove_index :records, :trip_id
    add_index :records, :trip_id, :unique => false
  end
end
