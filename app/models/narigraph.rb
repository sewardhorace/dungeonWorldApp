class Narigraph < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :character
  belongs_to :game

  self.per_page = 10
  def timestamp
    created_at.strftime('%b %-d %l:%M')
  end

  def roll(params)
    number_of_dice = params[:number_of_dice]
    number_of_sides = params[:number_of_sides]
    mod = params[:modifier]

    sides = number_of_sides.to_i
    result = 0
    number_of_dice.to_i.times do
      result += randomNumberOneTo(sides)
    end
    result += mod.to_i
    result = result < 0 ? 0 : result

    text = "Rolled #{number_of_dice}d#{number_of_sides}"
    if mod.to_i < 0
      text << "#{mod}"
    elsif mod.to_i > 0
      text << "+#{mod}"
    end
    text << ".  Result: #{result.to_s}"

    character_id = params[:narigraph][:character_id]
    game_id = params[:game_id]
    Narigraph.new(game_id: game_id, character_id: character_id, text: text, auto_generated: true)
  end

  def randomNumberOneTo(max_val)
    r = Random.new
    r.rand(max_val) + 1
  end

end
