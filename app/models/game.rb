require 'flickr_fu'

class Game < ActiveRecord::Base
  has_many :flickr_images
  attr_accessible :images_category, :tiles_count
  attr_accessor :tiles_count

  after_create :create_images

  protected
  def create_images
    @tiles_count = 24 if self.tiles_count.blank?
    puts @tiles_count
    flickr = Flickr.new('config/flickr.yml')
    photos = flickr.photos.get_recent(:pages => 1, :per_page => @tiles_count)
    photos.each do |photo|
      self.flickr_images << FlickrImage.create(:photo => photo)
    end
  end
end
