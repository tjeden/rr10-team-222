class User < ActiveRecord::Base
  belongs_to :game
  has_many :authorizations
  has_many :moves

  @@current = false

  def self.current=(user)
    @@current = user
  end

  def self.current
    @@current
  end

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
end
