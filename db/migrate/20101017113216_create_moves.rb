require "migrations_helpers"

class CreateMoves < ActiveRecord::Migration
  extend MigrationsHelpers

  def self.up
    create_table :moves do |t|
      t.references :user
      t.references :game
      t.integer :number
      t.integer :index1
      t.integer :index2
      t.timestamps
    end
    add_foreign_key :moves, :user_id, :users
    add_foreign_key :moves, :game_id, :games
  end

  def self.down
    drop_foreign_key :moves, :users
    drop_foreign_key :moves, :games
    drop_table :moves
  end
end
