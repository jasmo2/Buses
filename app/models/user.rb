# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           default(""), not null
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#

class User < ActiveRecord::Base
  # role: goes from top prority to less priority
  # It's better to write it as a hash because you can have the numbers
  #   guiding the roles
  enum role: {
           Gerente: 0,
           Admin: 1,
           Lector: 2,
           Editor: 3
       }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true
  # before_save :granted_permissions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :buses

  # The method checks if the user that is creating new users is at least 'Admin'
  def admin_save(new_user)
    if self.role == 'Gerente'
      return if  user_save(new_user)
    elsif self.role == 'Admin' && new_user.role == 'Admin'
      self.errors.add(:base, 'el usuario tiene que ser al menos administrador para poder guardar usuarios')
      return false
    else
      return user_save(new_user)
    end
  end

  def self.all_by_role(current_user)
    if current_user.Gerente?
      return self.all
    elsif current_user.Admin?
      return self.where('role != ? AND role != ?', User.roles['Admin'],User.roles['Gerente'])
    else
      self.errors.add(:base, 'Admin Tiene que ser almenos administrador para consultar usuarios')
      return false
    end
  end
  private
  # Before the save action is trigger check if the 'current_user' has 'Gerente' or 'Admin' Role
  def granted_permissions
    if self.role != 'Gerente' && self.role != 'Admin'
      self.errors.add(:base, 'Admin Tiene que ser almenos administrador para poder guardar usuarios')
        false
    end
  end
  def user_save user_save
    puts '∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆∆'
    puts "User #{self.username} role: #{self.role} ;\n is trying to save #{user_save}"
    user_save.save
    result = !User.where(:id => user_save.id).blank?

    puts "save?: #{user_save.username}; #{result}"

    result
  end
end
