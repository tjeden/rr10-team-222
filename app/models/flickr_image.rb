class FlickrImage < ActiveRecord::Base
  belongs_to :game

  def photo=(photo)
    self.farm = photo.farm 
    self.server = photo.server
    self.photo_id = photo.id
    self.secret = photo.secret 
  end
end
