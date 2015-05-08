class AddTripColumnToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :trip_column, :integer
  end
end
