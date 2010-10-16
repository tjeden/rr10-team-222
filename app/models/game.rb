require 'flickr_fu'

class Game < ActiveRecord::Base
  has_many :flickr_images
  attr_accessible :images_category

  after_create :create_images

  protected
  def create_images
    flickr = Flickr.new('config/flickr.yml')
    if self.images_category.present?
      photos = flickr.photos.search(:tags => self.images_category, :page => (rand*100).to_i, :per_page => 12)
    else
      photos = flickr.photos.get_recent(:pages => 1, :per_page => 12)
    end
    photos.each do |photo|
      self.flickr_images << FlickrImage.create(:photo => photo)
    end
  end
end
