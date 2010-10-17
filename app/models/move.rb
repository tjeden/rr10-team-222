class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  scope :hits, where(:result => true)
end
