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

  def active_user
    #first move - use first user
    return users.first if last_move.nil?
    next_user_flag = false
    users.each do |u|
      next_user_flag = true if last_move.user_id == user.id
      return user if next_user_flag #the user after the one that moved previously
    end
    #special case when previous move was performed by the last user - first user goes next
    return users.first
  end

  def my_turn?
    active_user == User.current
  end
end
