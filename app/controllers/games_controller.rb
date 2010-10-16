require 'flickr_fu'

class GamesController < ApplicationController

  def show
    if session[:current_game_id].blank?
      render :action => 'new_game'
    else
      @game = Game.find(session[:current_game_id])
      flickr = Flickr.new('config/flickr.yml')
      photos = flickr.photos.get_recent({})
      @photo = photos[0]
    end
  end

  def new
    @game = Game.create!
    session[:current_game_id] = @game.id
    redirect_to game_path
  end
  
end
