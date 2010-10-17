class GamesController < ApplicationController
  before_filter :check_permission, :only => :join

  def show
    if session[:current_game_id].blank?
      redirect_to new_game_path
    else
      @game = Game.find(session[:current_game_id])
      redirect_to new_game_path and return if @game.finished? or @game.canceled?
      redirect_to wait_path if @game.new? and signed_in? and @game.is_multi?
      @preloaded_images_list = @game.flickr_images.map{|img| "'#{img.get_url(:size => :small)}'" }.join(', ')
    end
  rescue
    redirect_to new_game_path
  end

  def new
    @game = Game.new
  end
  
  def create
    cancel_game
    @game = Game.new(params[:game])
    if @game.save
      @game.start!
      session[:current_game_id] = @game.id
      redirect_to game_path
    else
      render :action => :new
    end
  end

  def destroy  
    game = Game.find_by_id(params[:current_game_id])
    if game.blank? && signed_in?
      game = current_user.game
    end
    is_multi = game.try(:is_multi?)
    cancel_game
    if is_multi
      redirect_to lobby_path
    else
      redirect_to new_game_path
    end
  end
  
  def join
    game = Game::Multi.find(params[:game_id])
    if game.present? and game.can_be_joined_by_user?(current_user) and game.new?
      cancel_game unless game.has_user?(current_user)
      session[:current_game_id] = game.id
      current_user.update_attribute(:game_id, game.id)
      redirect_to wait_path
    else
      flash[:error] = "You cannot join this game"
      redirect_to lobby_path
    end
  end

end
