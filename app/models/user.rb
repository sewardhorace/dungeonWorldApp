class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :email, uniqueness: { case_sensitive: false }, email: true
  validates :username, uniqueness: { case_sensitive: false }, length: { maximum: 15 }

  has_many :players
  has_many :games, through: :players
  has_many :chats

  def is_playing_game?(game)
    games.all.include?(game)
  end

  def player_in_game(game)
    players.find_by(game_id: game.id)
  end

  def active_character_in_game(game)
    self.player_in_game(game).active_character
  end

  def owns_character?(character)
    self == character.player.user
  end

  def deactivate
    self.update(is_active: false)
  end

  def reactivate
    if self.is_active
      return
    end
    self.update(is_active: true)
  end
end
