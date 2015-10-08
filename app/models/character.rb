class Character < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 20 }

  enum role: [:player, :game_master]

  belongs_to :user
  belongs_to :game
  has_many :narigraphs

  def self.create_with_char_data(char_data, user, game)
    ActiveRecord::Base.transaction do
      begin
        Character.create(name: char_data[:name], char_data: char_data, user_id: user.id, game_id: game.id)
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
  end

  def set_active_character
    update_attribute(:is_active, true)
  end

  def set_party_member
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

end
