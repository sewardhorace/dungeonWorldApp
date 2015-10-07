class Game < ActiveRecord::Base

  belongs_to :gm, class_name: "User", foreign_key: "gm_id"
  has_and_belongs_to_many :users
  has_many :characters

  has_many :chats

  def timestamp
    created_at.strftime('%b %-d, %Y')
  end

  def game_master
    if player = players.where(role: 1).first
      return player.user
    end
    nil
  end

  def party_members
    players.map{|p| p.active_party_member}.compact
  end

  def non_party_characters
    #TODO
  end

  def is_active
    self.game_master.is_active
  end

  def self.new_game(game_params, user_id)
    ActiveRecord::Base.transaction do
      begin
        game = Game.create(game_params)
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
