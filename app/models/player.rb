class Player < ActiveRecord::Base

  enum role: [:player, :game_master]

  belongs_to :user
  belongs_to :game

  has_many :characters

  def active_character
    characters.where(is_active: true).first
  end

  def deactivate
    self.active_character.update(is_active: false)
    self.update(is_active: false)
    if self.role == "game_master"
      self.game.players.each { |p| p.deactivate if p.is_active }
    end
  end

  def reactivate
    self.update(is_active: true)
    if self.role == "game_master"
      self.characters.first.update(is_active: true)
      self.game.players.each { |p| p.reactivate unless p.is_active }
    end
  end
end
