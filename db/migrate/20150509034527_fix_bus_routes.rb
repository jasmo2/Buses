class FixBusRoutes < ActiveRecord::Migration
  def change
    rename_column :trips, :bus_routes_id, :bus_route_id
  end
end
