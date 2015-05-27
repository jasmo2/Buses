class AddColumnRegisterDatetoRecords < ActiveRecord::Migration
  def change
    add_column :records, :register_date, :date
  end
end
