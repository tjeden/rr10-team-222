class AddResultToMoves < ActiveRecord::Migration
  def self.up
    add_column :moves, :result, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :moves, :result
  end
end
