class GamesController < ApplicationController

  def show
    if session[:current_game_id].blank?
      redirect_to new_game_path
    else
      @game = Game.find(session[:current_game_id])
      @preloaded_images_list = @game.flickr_images.map{|img| "'#{img.get_url(:size => :small)}'" }.join(', ')
    end
  end

  def new
    @game = Game.new
  end
  
  def create
    if session[:current_game_id]
      Game.find(session[:current_game_id]).cancel! rescue nil
    end
    @game = Game.new(params[:game])
    if @game.save
      session[:current_game_id] = @game.id
      redirect_to game_path
    else
      render :action => :new
    end
  end
  
  def join
    game = Game::Multi.find(params[:game_id])
    if game.can_be_joined_by_user?(current_user)
      session[:current_game_id] = game.id
      current_user.update_attribute(:game_id, game.id)
      redirect_to wait_path
    else
      flash[:error] = "You cannot join this game"
      redirect_to lobby_path
    end
  end

end
