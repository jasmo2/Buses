class AddStartTimeToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :start_time, :time
  end
end
