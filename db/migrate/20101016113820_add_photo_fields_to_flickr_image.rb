class AddPhotoFieldsToFlickrImage < ActiveRecord::Migration
  def self.up
    add_column :flickr_images, :farm, :integer
    add_column :flickr_images, :server, :integer
    add_column :flickr_images, :photo_id, :string
    add_column :flickr_images, :secret, :string
    remove_column :flickr_images, :url
  end

  def self.down
    add_column :flickr_images, :url, :string
    remove_column :flickr_images, :secret
    remove_column :flickr_images, :photo_id
    remove_column :flickr_images, :server
    remove_column :flickr_images, :farm
  end
end
