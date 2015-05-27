class ChangeUserIdIndexInRecords < ActiveRecord::Migration
  def change
    remove_index :records, :user_id
    add_index :records, :user_id, :unique => false
  end
end
