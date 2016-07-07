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
  def require_student
    if !current_user.student? && !current_user.admin?
      flash[:auth_error] = "Sorry, you do not have access to that"
      redirect_to request.referer
    end
  end
  def require_teacher
    if !current_user.teacher? && !current_user.admin?
      flash[:auth_error] = "Sorry, you do not have access to that"
      redirect_to request.referer
    end
  end
  def require_admin
    if !current_user.admin? 
      flash[:auth_error] = "Sorry, you do not have access to that"
      redirect_to request.referer
    end
  end
end
