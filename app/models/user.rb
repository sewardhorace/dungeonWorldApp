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

  def join_game(game_id)
    ActiveRecord::Base.transaction do
      begin
        Player.create(user_id: id, game_id: game_id)
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
    true
  end

  def is_playing?(game_id)
    games.map { |g| g.id }.include?(game_id)
  end

  def deactivate
    self.update(is_active: false)
  end

  def reactivate
    self.update(is_active: true)
  end
end
