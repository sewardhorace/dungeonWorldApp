class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_many :players
  has_many :games, through: :players

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

end
