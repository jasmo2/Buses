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
  enum role: [:Gerente , :Admin,  :Lector, :Editor ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true
  before_save :granted_permissions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :buses
  has_many :records

  # The method checks if the user that is creting new users is at least 'Admin'
  def admin_save(new_user)

    if(self.role == "Gerente")
      return if new_user.save ? true : false
    elsif (self.role == "Admin" && new_user.role == "Admin")
      self.errors.add(:base, "Admin Tiene que ser almenos administrador para poder guardar usuarios")
      return false
    else
      return if new_user.save ? true : false    end
  end

  private
  def granted_permissions
    if self.role != "Gerente" && self.role != "Admin"
      self.errors.add(:base, "Admin Tiene que ser almenos administrador para poder guardar usuarios")
      return false
    end
  end
end
