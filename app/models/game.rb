require 'flickr_fu'

class Game < ActiveRecord::Base
  has_many :flickr_images
  attr_accessible :max_players, :images_category

  after_create :create_images

  protected
  def create_images
    flickr = Flickr.new('config/flickr.yml')
    photos = flickr.photos.get_recent(:pages => 1, :per_page => 24)
    photos.each do |photo|
      self.flickr_images << FlickrImage.create(:photo => photo)
    end
  end
end
