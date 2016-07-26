class UserController < ApplicationController
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		@user.role = params[:role]
		@user.verify_code = [*('a'..'z'),*('0'..'9'), *('A'..'Z')].shuffle[0,15].join 
		@user.is_verified = false
		SignupMailer.verify_account(@user).deliver
		if @user.save
			flash[:notice] = "#{@user.role} successfully created!"
			session[:user_id] = @user.id

			redirect_to '/user/' + @user.id.to_s
		else
			render 'new'
		end
	end
	def verify
		#MyLog.debug params[:user_email]
		@user = User.find_by email: params[:user_email]
		MyLog.debug @user
		if @user.verify_code == params[:code]
			@user.is_verified = true
			@user.save
			flash[:notice] = "Thank you for verifying your account"
		else
			flash[:error] = "Error verifying account"
		end
		redirect_to '/user/' + @user.id.to_s
	end
	def show
		@user = User.find(params[:id])
	end
	private 
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :verify_code, :is_verified)
	end
end
