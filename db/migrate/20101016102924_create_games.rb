class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :state
      t.integer :max_players
      t.string :images_category
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
