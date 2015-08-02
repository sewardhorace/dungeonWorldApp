class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true

  has_many :characters, dependent: :destroy
  has_many :user_games
  has_many :games, through: :user_games
  has_many :players

  def activeCharacter
    self.characters.first
  end
end
