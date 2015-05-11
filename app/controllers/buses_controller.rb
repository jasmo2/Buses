class BusesController < ApplicationController
  before_action :role_editor
  before_action :not_admin, only: [:import]

  def index
    render :index
  end
  def import
    begin
      Bus.add_routes(params[:file])
      flash[:notice] = "Los archivos se han cargado correctamente"
    rescue ArgumentError => e
      flash[:alert] = e.message
    end
      redirect_to action: "index", notice: "Rutas importadas"
  end       
end
