class UsersController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	def index
		unless user_signed_in?
			render "index"
		else
			case current_user.roles
			when "admin"
			when "editor"
				if cookies[:checkpoint] == nil
					redirect_to controller: "records", action: "new"
				else
					render :checkpoint
				end
			when "reader"
			end
			
		end
	end
	def checkpoint
		cookies[:checkpoint] = checkpoint_params[:checkpoint]  
		redirect_to controller: "records", action: "new"
	end
	private
	def checkpoint_params
		params.permit(:checkpoint)
	end
end
