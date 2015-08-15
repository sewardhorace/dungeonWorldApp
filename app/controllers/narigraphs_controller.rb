class NarigraphsController < ApplicationController
  #before_action :require_active_character, only:[:create]

  def index
    @narigraphs = game.narigraphs.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @narigraph = Narigraph.new
  end

  def create
    @narigraph = Narigraph.new(narigraph_params)
    pusher_save(@narigraph)
  end

  def move
    narigraph = Narigraph.new.roll(params)
    pusher_save(narigraph)
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

  def pusher_save(narigraph)
    respond_to do |format|
      if narigraph.save
        flash[:success] = 'successfil'

        Pusher['test_channel'].trigger('posted', {
          new_entry: narigraph.as_json,
          character: narigraph.character.as_json
        })

        format.html {redirect_to game_narigraphs_path(params[:game_id])}
        format.js
      else
        flash[:error] = 'nope erer'
      end
    end
  end
end
