class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user

  protected

  def set_user
    @user = current_user
    User.current = current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def check_permission
    redirect_to new_game_path unless signed_in?
  end
end
