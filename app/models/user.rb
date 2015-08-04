class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true

  has_many :characters, dependent: :destroy
  has_many :user_games
  has_many :games, through: :user_games
  has_many :players

  def join_game(game_id)
    ActiveRecord::Base.transaction do
      begin
        UserGame.create(user_id: id, game_id: game_id)
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
