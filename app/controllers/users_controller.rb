class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index]
  before_action :modify_user, only: [:edit,:destroy,:update]

	def index
		unless user_signed_in?
			render "index"
		else
			case current_user.role
			when "admin"
				render "dashboard"
			when "editor"
				if cookies[:checkpoint]
					redirect_to controller: "records", action: "new"
				else
					render :checkpoint
				end
			when "reader"
					redirect_to controller: "bus_routes", action: "index"
			end
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Se ah creado el nuevo usuario #{@user.username}"
			redirect_to action: "list_users"
		else
			render "new"
		end
	end

	def edit
	end

	def update
		@user.attributes = user_params
		if @user.save
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
		@users = User.all
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
		params[:user][:role] = role_converter(params[:user][:role])
		params.require(:user).permit(:username,:role,:email,:password,:password_confirmation)
	end

	def checkpoint_params
		params.permit(:checkpoint)
	end

	def role_converter(role)
		case role
			when "Admin" then role = "admin"
			when "Editor" then role = "editor"
			when "Lector" then role = "reader"
		end
		return role
	end
end
