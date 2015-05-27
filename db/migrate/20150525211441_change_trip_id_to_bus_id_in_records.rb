class ChangeTripIdToBusIdInRecords < ActiveRecord::Migration
  def change
    rename_column :records, :trip_id, :bus_id
  end
end
