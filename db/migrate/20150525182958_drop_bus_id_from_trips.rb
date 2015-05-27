class DropBusIdFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :bus_id
  end
end
