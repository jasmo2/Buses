class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  protected
  def role_editor
    if current_user.Editor?
      redirect_to controller: "records", action: "new"
    end
  end 
  def role_reader
    if current_user.Lector?
      redirect_to controller: "bus_routes", action: "index"
    end
  end 
 def not_admin
  unless current_user.Admin?
    redirect_to action: "index"
  end
 end
 def buses_role_verification
    if current_user.Admin? || current_user.Gerente?
      @buses = Bus.all
    else
      @buses = Bus.where(user_id: current_user.id)
    end
  end
end
