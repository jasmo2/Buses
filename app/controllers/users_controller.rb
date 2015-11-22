class UsersController < ApplicationController
	before_action :role_editor, if: :signed_in?, except: [:index, :checkpoint]
	before_action :role_reader, if: :signed_in?, except: [:index]
	before_action :authenticate_user!, except: [:index]
	before_action :modify_user, only: [:edit,:destroy,:update]

	def index
		unless user_signed_in?
			render "index"
		else
			case current_user.role
				when "Admin" , "Gerente"
					render "dashboard"
				when "Editor"
					if cookies[:checkpoint]
						redirect_to controller: "records", action: "new"
					else
						render :checkpoint
					end
				when "Lector"
					redirect_to controller: "records", action: "search"
				else
					puts"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
					puts"case not go into"
			end
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if current_user.admin_save(@user)
			puts "se ha creado el usuario #{@user.username} con id: #{@user.id}"
			flash[:notice] = "Se a creado el nuevo usuario #{@user.username}"
			redirect_to action: "list_users"
		else
			flash[:alert] = "El usuario #{@user.username} no pudo ser creado, revise su conexión"
			render "new"
		end
	end

	def edit
	end

	def update
		@user.attributes = user_params
		if current_user.admin_save(@user)
			flash[:notice] = "Se ah actualizado el usuario #{@user.username}"
			redirect_to action: "list_users"
		else
			render "new"
		end
	end

	def destroy
		@user.destroy
	end

	def list_users
		@users = User.all_by_role(current_user)
	end

	def checkpoint
		cookies.permanent[:checkpoint] = checkpoint_params[:checkpoint]
		redirect_to controller: "records", action: "new"
	end

	def bus_list
		@user = User.find(params[:id])
		@buses = Bus.where('user_id= ? OR user_id IS ?', @user.id, nil)
	end


# ----------
	private

	def modify_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username,:role,:email,:password,:password_confirmation)
	end

	def checkpoint_params
		params.permit(:checkpoint)
	end

end
