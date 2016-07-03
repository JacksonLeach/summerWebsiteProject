class UserController < ApplicationController
	def new
		@user = User.new

	end
	def create
		@user = User.new(user_params)
		@user.role = params[:role]
		if @user.save
			flash[:notice] = "#{@user.role} successfully created!"
			session[:user_id] = @user.id
			redirect_to '/'
		else
			redirect_to '/signup'
		end
	end
	def show
		@user = User.find(params[:id])
	end
	private 
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
	end
end
