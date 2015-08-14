class Game < ActiveRecord::Base

  has_many :players
  has_many :narigraphs

  def timestamp
    created_at.strftime('%b %-d, %Y')
  end

  def game_master
    if player = players.where(role: 1).first
      return player.user
    end
    nil
  end

  def self.new_game(game_params, user_id)
    ActiveRecord::Base.transaction do
      begin
        game = Game.create(game_params)
        UserGame.create(user_id: user_id, game_id: game.id)
        player = Player.create(user_id: user_id, game_id: game.id, role: 1)
        Character.create(player_id: player.id, name: "GM", is_active: true)
        return game
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
  end
end
