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
    puts "*"*100
    puts character.name
    puts "*"*100
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
    game = Game.find(params[:game_id])
    user = User.find(params[:user_id])
    # TODO - anyone can join any game even if it's no longer active
    if game && user
      if user.join_game(game.id)
        redirect_to game_path(game)
      else
        redirect_to games_path, notice: "Flub butt"
      end
    else
      redirect_to games_path, notice: "This game doesn't exist"
    end
  end

  def leave

  end

  private
  def game_params
    params.require(:game).permit(:description)
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
    player.active_party_member
  end

  def game
    @game if defined?(@game)
    @game = Game.find(params[:game_id])
  end
end
