class GamesController < ApplicationController

  def show
    if session[:current_game_id].blank?
      redirect_to new_game_path
    else
      @game = Game.find(session[:current_game_id])
    end
  end

  def new
    @game = Game.new
    
    # retrieve random photos from Flickr
    # @photos = []
    # flickr = Flickr.new('config/flickr.yml')
    # flickr.photos.get_recent(:pages => 1, :per_page => 3).each do |photo|
    #   @photos << FlickrImage.new(:photo => photo)
    # end
  end
  
  def create
    if session[:current_game_id]
      Game.find(session[:current_game_id]).update_attribute(:state, 'inactive') rescue nil
    end
    @game = Game.new(params[:game])
    if @game.save
      session[:current_game_id] = @game.id
      redirect_to game_path
    else
      render :action => :new
    end
  end
  
end
