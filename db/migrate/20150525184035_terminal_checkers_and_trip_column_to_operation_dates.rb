class TerminalCheckersAndTripColumnToOperationDates < ActiveRecord::Migration
  def change
    add_column :operation_dates, :terminal, :boolean ,default: true
    add_column :operation_dates, :trip_column, :integer, default: 0
  end
end
