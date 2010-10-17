class User < ActiveRecord::Base
  belongs_to :game
  has_many :authorizations

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
end
