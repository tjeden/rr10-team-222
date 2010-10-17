require "migrations_helpers"

class AddGameIdToUser < ActiveRecord::Migration
  extend MigrationsHelpers

  def self.up
    add_column :users, :game_id, :integer
    add_foreign_key :users, :game_id, :games
  end

  def self.down
    drop_foreign_key :users, :games
    remove_column :users, :game_id
  end
end
