class ChangeColumnNameTimeToRegisterTimeInRecords < ActiveRecord::Migration
  def change
    rename_column :records, :time, :register_time
  end
end
