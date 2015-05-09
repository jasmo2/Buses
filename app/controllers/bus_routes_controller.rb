class BusRoutesController < ApplicationController
  before_action :role_editor
  before_action :not_admin, only: [:import]
  def index
    if current_user.admin?
      @bus_routes = BusRoute.all
      unless @bus_routes.empty?
        @counter = @bus_routes.max_by { |bus_route| bus_route.trips.count }
        @counter = @counter.trips.count
      else
        @counter = 1
      end
      render "index"
    else
      
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
 def not_admin
  unless current_user.admin?
    redirect_to action: "index"
  end
 end
end
