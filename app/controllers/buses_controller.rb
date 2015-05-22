class BusesController < ApplicationController
  before_action :role_editor
  before_action :role_verification, only: [:index, :list_buses]
  before_action :new_bus, only: [:new]
  before_action :modify_bus, only: [:edit,:destroy]
  before_action :not_admin, only: [:import]

  def index
  end

  def list_buses
  end

  def edit
    render "new.js.erb"
  end

  def bus_assignment
    Bus.update_multiple(params[:user_id],params[:buses_assignment],params[:buses])
    redirect_to :back
  end

  def update
    redirect_to action: "list_buses"
  end
  def destroy
    @bus.destroy
    redirect_to action: "list_buses"
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
  def role_verification
    if current_user.admin?
      @buses = Bus.all
    else
      @buses = Bus.where(user_id: current_user.id)
    end
  end
  def new_bus
    @bus = Bus.new
  end
  def modify_bus
    @bus = Bus.find(params[:id])
  end
  def bus_params
    params.require(:bus).permit(:id,:plate_license,:driver_name)
  end     
end
