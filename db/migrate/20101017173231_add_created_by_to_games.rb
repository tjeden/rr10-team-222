require "migrations_helpers"

class AddCreatedByToGames < ActiveRecord::Migration
extend MigrationsHelpers

  def self.up
    add_column :games, :created_by, :integer
    add_foreign_key :games, :created_by, :users
  end

  def self.down
    drop_foreign_key :games, :users
    remove_column :games, :created_by
  end
end
