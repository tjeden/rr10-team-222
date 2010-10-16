class AddLastRevealToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :last_revealed, :integer
  end

  def self.down
    remove_column :games, :last_revealed
  end
end
