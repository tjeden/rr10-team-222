require 'flickr_fu'

class GamesController < ApplicationController
  def show
    flickr = Flickr.new('config/flickr.yml')
    photos = flickr.photos.get_recent({})
    @photo = photos[0]
  end
end
