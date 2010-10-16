class Tile < ActiveRecord::Base

  MAX_ORDER_INDEX = 1000000

  belongs_to :game
  belongs_to :flickr_image

  before_create :allot_order_index

  def allot_order_index
    self.order_index = rand(MAX_ORDER_INDEX)
  end

end
