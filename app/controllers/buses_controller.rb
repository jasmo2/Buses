require 'json'
class BusesController < ApplicationController
  before_action :role_editor
  before_action :role_reader
  before_action :buses_role_verification, only: [:index, :list_buses]
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
    respond_to do |format|
      format.json {
        buses =  assignment_buses
        Bus.update(buses.keys,buses.values)
        render json: nil, status: :ok
      }
    end
    # flash[:notice] = "Los buses fueron asignados correctmente"
    # redirect_to :back
  end

  def update
    Bus.update(params[:id], bus_params)
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

  def new_bus
    @bus = Bus.new
  end
  def modify_bus
    @bus = Bus.find(params[:id])
  end
  def bus_params
    params.require(:bus).permit(:id,:plate_license,:driver_name)
  end
  def assignment_buses
    buses = Hash.new
    params['buses_assignment'].each do |bus|
      buses[bus[0].to_s] = {"user_id" => bus[1]["user_id"].to_s == "" ? nil :  bus[1]["user_id"].to_i}
    end
    buses
  end


end
