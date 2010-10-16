require 'flickr_fu'

class GamesController < ApplicationController
  def show
    flickr = Flickr.new('config/flickr.yml')
    @photos = flickr.photos.get_recent(:pages => 1, :per_page => 25)
  end
end
