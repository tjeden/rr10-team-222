require 'flickr_fu'

class Game < ActiveRecord::Base
  has_many :flickr_images
  has_many :tiles, :order => 'order_index'
  attr_accessible :images_category

  after_create :create_images

  def get_photo_from_tile(index)
    tiles[index].flickr_image
  end

  protected
  def create_images
    flickr = Flickr.new('config/flickr.yml')
    photos = flickr.photos.get_recent(:pages => 1, :per_page => 12)
    photos.each do |photo|
      self.flickr_images.create(:photo => photo)
    end
  end
end
