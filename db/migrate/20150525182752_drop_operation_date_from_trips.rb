class DropOperationDateFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :operation_date
  end
end
