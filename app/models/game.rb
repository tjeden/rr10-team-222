require 'flickr_fu'

class Game < ActiveRecord::Base
  has_many :flickr_images
  has_many :tiles, :order => 'order_index'
  attr_accessible :images_category

  after_validation :create_images
  after_create :save_images

  def get_photo_from_tile(index)
    tiles[index].flickr_image
  end

  protected
  def create_images
    flickr = Flickr.new('config/flickr.yml')
    if self.images_category.present?
      photos = flickr.photos.search(:tags => self.images_category, :page => (rand*100).to_i, :per_page => 12)
    else
      photos = flickr.photos.get_recent(:pages => 1, :per_page => 12)
    end
    errors.add( :images_category, 'There is not enough photos in this category') if photos.size < 12
    photos.each do |photo|
      self.flickr_images << FlickrImage.new(:photo => photo)
    end
  end

  def save_images
    self.flickr_images.each { |image| image.save! }
  end
end
