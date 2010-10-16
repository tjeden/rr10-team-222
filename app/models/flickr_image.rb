class FlickrImage < ActiveRecord::Base
  belongs_to :game
  validates_presence_of :farm, :server, :photo_id, :secret

  def photo=(photo)
    self.farm = photo.farm 
    self.server = photo.server
    self.photo_id = photo.id
    self.secret = photo.secret 
  end
end
