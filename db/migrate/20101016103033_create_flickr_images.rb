require "migrations_helpers"

class CreateFlickrImages < ActiveRecord::Migration
  extend MigrationsHelpers

  def self.up
    create_table :flickr_images do |t|
      t.string :url
      t.references :game
      t.timestamps
    end

    add_foreign_key :flickr_images, :game_id, :games
  end

  def self.down
    drop_foreign_key :flickr_images, :games
    drop_table :flickr_images
  end
end
