class Narigraph < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :character
  belongs_to :game

  self.per_page = 10 #for pagination

  def timestamp
    created_at.strftime('%b %-d %l:%M')
  end

  def self.create_with_character_and_game_id(character, game_id, params)
    narigraph = Narigraph.new()
    narigraph.text = params["text"]
    narigraph.character_id = params["character_id"] || character.id
    narigraph.game_id = params["game_id"] || game_id
    narigraph.character_name = character.name
    narigraph.save
  end
end
