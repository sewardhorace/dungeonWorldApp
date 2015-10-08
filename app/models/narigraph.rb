class Narigraph < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :character

  self.per_page = 10 #for pagination

  def timestamp
    created_at.strftime('%b %-d %l:%M')
  end

  def self.create_with_character(character, params)
    narigraph = Narigraph.new()
    narigraph.text = params["text"]
    narigraph.character_id = params["character_id"] || character.id
    narigraph.character_name = character.name
    narigraph.save
  end
end
