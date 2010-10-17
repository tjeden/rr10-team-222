class Game::Multi < Game
  has_many :users, :foreign_key => 'game_id'

  before_create :set_max_players

  def can_be_joined?
    users.count < max_players
  end

  def can_be_joined_by_user?(user)
    can_be_joined? && !(users.any?{ |u| u == user})
  end

  protected
  def set_max_players
    self.max_players = 4
  end
end
