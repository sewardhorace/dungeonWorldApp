class NarigraphsController < ApplicationController
  # before_action :require_active_character, only:[:create]

  def index
    @narigraphs = game.narigraphs.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @narigraph = Narigraph.new
  end

  def create
    puts '*' * 100
    puts narigraph_params
    puts '*' * 100
    @narigraph = Narigraph.new(narigraph_params)
    pusher_save(@narigraph)
    head :ok
  end

  def move_roll
    if request.xhr?
      roll = Roll.new(roll_params)
      narigraph = Narigraph.new(narigraph_params)
      narigraph.text = roll.description
      narigraph.auto_generated = true
      if narigraph.save
        head :ok
      else
        render status: 500
      end
    else
      render status: 404
    end
  end

  helper_method :player
  def player
    @player if defined?(@player)
    @player = Player.find_by(user_id: current_user.id, game_id: params[:game_id])
  end

  helper_method :game
  def game
    @game if defined?(@game)
    @game = Game.find_by(id: params[:game_id])
  end

  private

  def narigraph_params
    params.require(:narigraph).permit(:game_id, :character_id, :text)
  end

  def roll_params
    params.require(:roll).permit(:number_of_dice, :number_of_sides, :modifier)
  end

  def pusher_save(narigraph)
    respond_to do |format|
      if narigraph.save
        flash[:success] = 'successfil'
        return true
      else
        flash[:error] = 'nope erer'
        return false
      end
    end
  end
end
