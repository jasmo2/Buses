module UsersHelper
	def role_assigment_limitation(current_user)
    roles = User.roles.keys

    if current_user.Admin?
      roles.delete("Gerente")
      roles.delete("Admin")
    end
    roles
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
