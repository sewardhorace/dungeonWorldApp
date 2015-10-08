class Game < ActiveRecord::Base

  belongs_to :gm, class_name: "User", foreign_key: "gm_id"
  has_many :characters
  has_many :users, through: :characters
  has_many :narigraphs, through: :characters

  has_many :chats

  def timestamp
    created_at.strftime('%b %-d, %Y')
  end

  def party_members
    characters.where(is_party_member: true)
  end

  def non_party_members
    characters.where(is_party_member: false, role: 0)
  end

  def is_active
    self.gm.is_active
  end

  def self.new_game(game_params, user)
    ActiveRecord::Base.transaction do
      begin
        game = Game.create(game_params)
        game.update_attributes(gm_id: user.id)
        Character.create(user_id: user.id, game_id: game.id, name: "GM", is_active: true, role: 1)
        return game
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
  end
end
