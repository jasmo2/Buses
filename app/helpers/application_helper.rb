module ApplicationHelper
  def header_role(role)
    case role
    when "admin"
      return "Administrador"
    when "editor"
      return "Editor"
    when "reader"
      return "Lector"
    end
  end
  def navbar
    if  user_signed_in?
      if cookies[:checkpoint]
        render "layouts/header"
      elsif current_user.reader? || current_user.admin?
        render "layouts/header"
      end
    end
  end
end
