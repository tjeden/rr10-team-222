class Game < ActiveRecord::Base
  has_many :flickr_images
  attr_accessible :max_players, :images_category
end
