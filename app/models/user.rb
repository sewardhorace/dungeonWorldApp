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

  def join_game(game)
    ActiveRecord::Base.transaction do
      begin
        Player.create(user_id: id, game_id: game.id)
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
    true
  end

  def is_playing_game?(game) #TODO check if used anywhere
    games.all.include?(game)
  end

  def player_in_game(game) #TODO check if used anywhere
    players.find_by(game_id: game.id)
  end

  def owns_character?(character)
    players.all.include?(character.player)
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
