class Game::Multi < Game
  validates_presence_of :max_players
  validates_numericality_of :max_players, :greater_than => 1, :less_than => 5
  attr_accessible :max_players
end
