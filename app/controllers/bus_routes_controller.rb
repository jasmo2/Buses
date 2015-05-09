class BusRoutesController < ApplicationController
  before_action :role_editor
  def index
  end

  def import
    begin
      BusRoute.import(params[:file])
      flash[:notice] = "Los archivos se han cargado correctamente"
    rescue ArgumentError => e
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Exception catched"
      puts e
      puts ""
      flash[:alert] = e.message
    end
      redirect_to action: "index", notice: "Rutas importadas"
  end
 
end
