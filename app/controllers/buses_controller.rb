class BusesController < ApplicationController
  before_action :role_editor
  before_action :new_bus, only: [:new]
  before_action :not_admin, only: [:import]

  def index
    render "index"
  end

  def list_buses
    
  end

  def new
  end

  def create
    @bus = Bus.new(bus_params)

    respond_to do |format|
       if @bus.save
          flash[:notice] = 'El bus fué creado exitosamente'
          format.html {  redirect_to  action: "list_buses" }
          format.json
       else   
          flash[:alert] = 'no se ah podido guardar el autobus'
          format.html { redirect_to action: 'list_buses'}
          format.json { render json: @bus.errors, status: :unprocessable_entity }
       end
     end
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
  private
  def new_bus
    @bus = Bus.new
  end
  def bus_params
    params.require(:bus).permit(:id,:plate_license,:driver_name)
  end     
end
