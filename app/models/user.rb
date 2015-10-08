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

  has_many :characters
  has_many :games, through: :characters

  def is_playing_game?(game)
    games.all.include?(game)
  end

  def active_character_in_game(game)
    Character.find_by(user_id: self.id, game_id: game.id) || NullCharacter.new
  end

  def owns_character?(character)
    self == character.user
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
