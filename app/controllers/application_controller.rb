class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def role_editor
    if current_user.editor?
      redirect_to controller: "records", action: "new"
    end
  end 
  def role_reader
    if current_user.reader?
      redirect_to controller: "bus_routes", action: "index"
    end
  end 
end
