require "migrations_helpers"

class CreateTiles < ActiveRecord::Migration
  extend MigrationsHelpers

  def self.up
    create_table :tiles do |t|
      t.integer :order_index
      t.boolean :visible, :null => false, :default => false
      t.references :game
      t.references :flickr_image
      t.timestamps
    end

    add_foreign_key :tiles, :game_id, :games
    add_foreign_key :tiles, :flickr_image_id, :flickr_images

  end

  def self.down
    drop_foreign_key :tiles, :games
    drop_foreign_key :tiles, :flickr_images
    drop_table :tiles
  end
end
