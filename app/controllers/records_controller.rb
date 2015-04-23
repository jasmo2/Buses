class RecordsController < ApplicationController
  before_action :role_admin
  def new
    @record = Record.new()
  end
  def create
    record = Record.new(record_params)
    if record.save
      flash[:notice] = "El registro ha sido exitoso"
    else
      flash[:alert] = "No se ah podido registrar intentelo de nuevo"
    end  
    redirect_to new_record_path 

  end
  private
  def record_params
    params.require(:record).permit(:time,:quantity,:bus_id)
  end
  def role_admin
    if current_user.reader?
      redirect_to controller: "bus_routes", action:index
    end
  end  
end