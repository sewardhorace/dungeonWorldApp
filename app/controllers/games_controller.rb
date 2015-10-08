class GamesController < ApplicationController
  before_action :require_login
  helper_method :game, :character

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
    if @game = Game.new_game(game_params, current_user)
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

  def leave
    redirect_to game_path(game), notice: "You can't leave! Bahahah!"
  end

  def character
    current_user.active_character_in_game(game) || NullCharacter.new
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
