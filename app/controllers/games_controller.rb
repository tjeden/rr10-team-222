require 'flickr_fu'

class GamesController < ApplicationController

  def show
    if session[:current_game_id].blank?
      redirect_to new_game_path
    else
      @game = Game.find(session[:current_game_id])
      flickr = Flickr.new('config/flickr.yml')
      @photos = flickr.photos.get_recent(:pages => 1, :per_page => 24)
    end
  end

  def new

  end
  
  def create
    if session[:current_game_id]
      Game.find(session[:current_game_id]).destroy rescue nil
    end
    @game = Game.create!(params[:game])
    session[:current_game_id] = @game.id
    redirect_to game_path
  end
  
end
