class UsersController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	def index
		unless user_signed_in?
			render 'index'
		else
			render 'admin_index'
		end
	end
	def show
		
	end
end
