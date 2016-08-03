class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def require_user
  	redirect_to '/login' unless current_user
  end
  def check_verified
  	redirect_to '/nonverified' unless current_user.is_verified
  end
  def require_student
  	if current_user != nil
	    if !current_user.student? && !current_user.admin?
	      flash[:auth_error] = "Sorry, you do not have access to that"
	      redirect_to request.referer
	    end
	  else
	  	flash[:auth_error] = "Sorry, you do not have access to that"
	  	redirect_to login_path
	  end
  end
  def require_teacher
  	if current_user != nil
	    if !current_user.teacher? && !current_user.admin?
	      flash[:auth_error] = "Sorry, you do not have access to that"
	      redirect_to request.referer
	    end
	  else
	  	flash[:auth_error] = "Sorry, you do not have access to that"
	  	redirect_to login_path
	  end
  end
  def require_admin
  	if current_user != nil
	    if !current_user.admin? 
	      flash[:auth_error] = "Sorry, you do not have access to that"
	      redirect_to request.referer
	    end
	  else
	  	flash[:auth_error] = "Sorry, you do not have access to that"
	  	redirect_to login_path
	  end
  end
  class MyLog
	  def self.debug(message=nil)
	    @my_log ||= Logger.new("#{Rails.root}/log/my.log")
	    @my_log.debug(message) unless message.nil?
	  end
	end
end
