class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
  end


  # def full_name
  # User.find(session[:user_id]).first_name + " " +
  # User.find(session[:user_id]).last_name
  # end
  # helper_method :full_name

  def full_name
    "#{first_name} #{last_name}"
  end
  helper_method :full_name

end
