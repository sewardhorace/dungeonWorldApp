class Character < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 20 }
  belongs_to :player
  has_many :narigraphs

  def set_active_character
    player.characters.each { |c| c.update_attribute(:is_active, false) }
    update_attribute(:is_active, true)
  end

  # game logic
  def strmod
    get_ability_mod(self.str)
  end

  def dexmod
    get_ability_mod(self.dex)
  end

  def conmod
    get_ability_mod(self.con)
  end

  def intmod
    get_ability_mod(self.int)
  end

  def wismod
    get_ability_mod(self.wis)
  end

  def chamod
    get_ability_mod(self.cha)
  end

  private
  def get_ability_mod(score)
    case score
    when 1,2,3
      -3
    when 4,5
      -2
    when 6,7,8
      -1
    when 9,10,11,12
      0
    when 13,14,15
      1
    when 16,17
      2
    when 18
      3
    end
  end
end
