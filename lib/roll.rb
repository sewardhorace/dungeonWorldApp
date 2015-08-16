class Roll

  attr_accessor :number_of_dice, :number_of_sides, :mod, :results

  def initialize(opts)
    @number_of_dice = opts[:number_of_dice].to_i
    @number_of_sides = opts[:number_of_sides].to_i
    @mod = opts[:modifier].to_i
    @results = roll
  end

  def description
    text = "Rolled #{@number_of_dice}d#{@number_of_sides}"
    if @mod < 0
      text << "#{@mod}"
    elsif @mod > 0
      text << "+#{@mod}"
    end
    text << ".  Result: #{@results}"
  end

  private

  def roll
    result = 0
    @number_of_dice.times do
      result += Random.new.rand(@number_of_sides) + 1
    end
    result += @mod
    result = result < 0 ? 0 : result
  end

end
