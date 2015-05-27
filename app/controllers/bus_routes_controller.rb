class BusRoutesController < ApplicationController
  before_action :role_editor
  before_action :not_admin, only: [:import]
  def index
    @bus_routes = BusRoute.all
    @counter = trip_columns(@bus_routes)
    render "index"
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
