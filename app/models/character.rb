class Character < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :player
  has_many :narigraphs

  def set_active_character
    player.characters.each { |c| c.update_attribute(:is_active, false) }
    update_attribute(:is_active, true)
  end
end
