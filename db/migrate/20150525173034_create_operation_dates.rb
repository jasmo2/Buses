class CreateOperationDates < ActiveRecord::Migration
  def change
    create_table :operation_dates do |t|
      t.date :operation_date
      t.integer :bus_id
      t.integer :bus_route_id
      t.timestamps null: false
    end
  end
end
