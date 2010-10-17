class Game::Multi < Game
  has_many :users, :foreign_key => 'game_id'
  validates_presence_of :max_players
  validates_numericality_of :max_players, :greater_than => 1, :less_than => 5
  attr_accessible :max_players

  def can_be_joined?
    users.count < max_players
  end

  def can_be_joined_by_user?(user)
    can_be_joined? && !(users.any?{ |u| u == user})
  end
end
