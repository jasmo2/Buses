class UpdateTripColumnOperationDate < ActiveRecord::Migration
  def change
    change_column :trips, :operation_date, :date, :null => true
  end
end
