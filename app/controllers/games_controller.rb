class GamesController < ApplicationController
  before_action :require_login
  helper_method :game, :user, :player, :character

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    game
  end

  def play
    character
  end

  def create
    if @game = Game.new_game(game_params, user.id)
      redirect_to game_path(@game)
    else
      redirect_to new_game_path, notice: "There was a problem creating your game"
    end
  end

  def edit
    game
  end

  def update
    if game.update(game_params)
      redirect_to game_path(game)
    else
      render 'edit'
    end
  end

  def destroy
    Game.destroy(game.id)
    redirect_to games_path
  end

  def join
    game = current_game
    if current_user.join_game(game)
      redirect_to game_path(game)
    else
      redirect_to games_path, notice: "Flub butt"
    end
  end

  def leave
    redirect_to game_path(current_game), notice: "You can't leave! Bahahah!"
  end

  def user
    @user if defined?(@user)
    @user = current_user
  end

  def player
    @player if defined?(@player)
    @player = Player.find_by(user_id: current_user.id, game_id: game.id)
  end

  def character
    if game.game_master == current_user
      player.active_character
    else
      player.active_party_member
    end
  end

  def game
    @game if defined?(@game)
    @game = Game.find(params[:id])
  end

  private
  def game_params
    params.require(:game).permit(:description)
  end
end
