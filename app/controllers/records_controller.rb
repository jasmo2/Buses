class RecordsController < ApplicationController
  before_action :role_reader, except: [:data_list, :search]
  before_action :validates_cookies, except: [:data_list,:search]
  before_action :buses_role_verification, only: [:search]
  def search
  end

  def data_list
    @records = Record.where(bus_id: params["bus_id"], register_date: params["date-route-bus"])
    render "data_list.js.erb"
  end

  def new
  end
  def create
    record = Record.new(record_params)
    record.register_type = cookies[:checkpoint]
    if record.save
      flash[:notice] = "El registro ha sido exitoso"
    else
      flash[:alert] = record.errors.full_messages
    end  
    redirect_to new_record_path 
  end
  private
  def record_params
    params.permit(:quantity,:user_id,:bus_id)
  end 
  def validates_cookies
    if !cookies[:checkpoint]
      redirect_to controller: "users", action: "index"
    end
  end
end