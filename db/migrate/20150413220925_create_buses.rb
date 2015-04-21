class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.string :create
      t.string :update
      t.string :plate_license

      t.timestamps null: false
    end
    
  end
end
