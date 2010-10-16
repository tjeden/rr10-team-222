class FlickrImage < ActiveRecord::Base
  belongs_to :game
  has_many :tiles
  validates_presence_of :farm, :server, :photo_id, :secret

  after_create :assign_tile_pair

  def photo=(photo)
    self.farm = photo.farm 
    self.server = photo.server
    self.photo_id = photo.id
    self.secret = photo.secret 
  end

  protected
  def assign_tile_pair
    2.times do
      Tile.create(:flickr_image => self, :game => self.game)
    end
  end
end
