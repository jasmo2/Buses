class BusRoutesController < ApplicationController
  before_action :role_editor
  before_action :not_admin, only: [:import]
  def index
    if current_user.admin?
      @bus_routes = BusRoute.all
      @counter = trip_columns(@bus_routes)
      render "index"
    else
      @bus_routes= []
      buses = Bus.where(user_id: current_user.id)
      buses.each do |bus|  
        @bus_routes << bus.bus_routes
      end
      @counter = trip_columns(@bus_routes)
    end
  end

  def import
    begin
      BusRoute.import(params[:file])
      flash[:notice] = "Los archivos se han cargado correctamente"
    rescue ArgumentError => e
      flash[:alert] = e.message
    end
      redirect_to action: "index", notice: "Rutas importadas"
  end

  private
  def trip_columns(bus_routes)
    unless bus_routes.empty?
        counter = bus_routes.max_by { |bus_route| bus_route.trips.count }
        counter = counter.trips.count
      else
        counter = 1
      end
      return counter
  end
end
