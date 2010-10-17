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
    quit_game unless signed_in?
  end

  def quit_game
    respond_to do |wants|
      wants.html  { redirect_to game_destroy_url }
      wants.js    { render :js => "window.location = '#{game_destroy_url}'" }
    end
  end

  protected

  def cancel_game
    return if session[:current_game_id].blank?
    old_game = Game.find(session[:current_game_id])
    old_game.cancel! if old_game.is_current_user_owner?
    current_user.update_attribute('game_id', nil) if current_user
    session[:current_game_id] = nil
  rescue
  end
end
