
class AutorizeCreation
  attr_accessor :current_user
  def initialize current_user
    @current_user = current_user
  end


  def admin_save(new_user)
    if @current_user.role == 'Gerente'
      return user_save(new_user)
    elsif @current_user.role == 'Admin' && new_user.role == 'Admin'
      @current_user.errors.add(:base, 'el usuario tiene que ser al menos administrador para poder guardar usuarios')
      return false
    else
      return user_save(new_user)
    end
  end
  private
  def user_save user_save
    puts '∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆'
    puts "User #{@current_user.username} role: #{@current_user.role} ;\n is trying to save #{user_save}"
    user_save.save
    result = !User.where(:id => user_save.id).blank?

    puts "save?: #{user_save.username}; #{result}"

    result
  end
end