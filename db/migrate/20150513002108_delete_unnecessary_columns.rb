class DeleteUnnecessaryColumns < ActiveRecord::Migration
  def change
    remove_column :buses, :create
    remove_column :buses, :update
  end
end
