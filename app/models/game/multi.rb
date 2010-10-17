class Game::Multi < Game
  has_many :users, :foreign_key => 'game_id'
  belongs_to :created_by, :class_name => 'User', :foreign_key => 'created_by'

  before_create :set_max_players
  before_create :set_user


  def can_be_joined?
    users.count < max_players
  end

  def can_be_joined_by_user?(user)
    can_be_joined? && !(users.any?{ |u| u == user})
  end

  def is_current_user_owner?
    created_by == User.current
  end

  def active_user
    #first move - use first user
    return users.first if last_move.nil?
    next_user_flag = false
    users.each do |user|
      logger.debug("Checking user: #{user}")
      return user if next_user_flag #the user after the one that moved previously
      next_user_flag = true if last_bad_move.user_id == user.id
    end
    logger.debug("beginning")

    #special case when previous move was performed by the last user - first user goes next
    return users.first
  end

  def my_turn?
    active_user == User.current
  end
  
  protected
  def set_max_players
    self.max_players = 4
  end

  def set_user
    self.created_by = User.current
  end
end
