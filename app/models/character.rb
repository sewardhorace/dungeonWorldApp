class Character < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 20 }

  belongs_to :player
  has_many :narigraphs

  def set_active_character
    player.characters.each { |c| c.update_attribute(:is_active, false) }
    update_attribute(:is_active, true)
  end

  def set_party_member
    player.characters.each { |c| c.update_attribute(:is_party_member, false) }
    update_attribute(:is_party_member, true)
  end

  # game logic
  def data
    CharData.new(read_attribute(:char_data))
  end

  class CharData
    attr_accessor :abilities, :alignment, :looks

    def initialize(hash)
      @abilities = hash['abilities']
      @alignment = hash['alignment']
      @looks = hash['looks']
    end
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
