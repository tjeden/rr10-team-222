require 'flickr_fu'

class Game < ActiveRecord::Base
  has_many :flickr_images
  has_many :tiles, :order => 'order_index'
  has_many :moves, :order => 'number'
  has_one :last_move, :class_name => 'Move', :foreign_key => 'game_id', :order => 'number DESC'

  before_validation :format_tags
  after_validation :create_images
  after_create :save_images

  ###### WORKFLOW #######
  include Workflow
  workflow_column :state
  workflow do
    state :new do
      event :start, :transitions_to => :playing
      event :cancel, :transitions_to => :canceled
    end
    state :playing do
      event :finish, :transitions_to => :finished
      event :cancel, :transitions_to => :canceled
    end
    state :finished do
      event :cancel, :transitions_to => :finished #nie zmieniamy stanu!
    end
    state :canceled
  end
  #######################

  scope :created, where(:state => 'new')

  attr_accessible :images_category
  attr_accessor :pair_reveal_result

  def get_photo_from_tile(index)
    tiles[index].flickr_image
  end

  def reveal_tile(tile_index, user = nil)
    self.pair_reveal_result = false
    if last_revealed.blank?
      update_attribute(:last_revealed, tile_index )
    else
      check_pair(tile_index, last_revealed, user)
    end
  end

  def over?
    tiles.all?{ |tile| tile.visible? }
  end

  protected

  def check_pair(tile_index, previously_revealed_index, user)
    if tile_index != previously_revealed_index
      if get_photo_from_tile(tile_index) == get_photo_from_tile(previously_revealed_index)
        tiles[tile_index].update_attribute(:visible, true)
        tiles[previously_revealed_index].update_attribute(:visible, true)
        self.pair_reveal_result = true
      end
      update_attribute(:last_revealed, nil )
      self.last_move = moves.create!(:number => (last_move.number+1 rescue 1), :user_id => (user.id rescue nil), :index1 => tile_index, :index2 => previously_revealed_index)
    end
  end

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

  def format_tags
    self.images_category.gsub!(' ',',') if self.images_category.present?
  end
end
