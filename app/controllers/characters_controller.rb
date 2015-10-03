class CharactersController < ApplicationController
  before_action :require_login
  before_action :require_is_player, only:[:new, :create]
  before_action :require_character_owner, only:[:edit, :destroy]

  def index
    @characters = current_user.characters
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = Character.new
  end

  def edit
    @character = Character.find(params[:id])
  end

  def create
    @character = player.characters.create(character_params)
    if @character.save
      flash[:notice] = "Welcome, #{@character.name}!"
      redirect_to character_path(@character)
    else
      flash[:alert] = "Your character had incomplete fields. Try again."
      render 'new'
    end
  end

  def update
    @character = Character.find(params[:id])
    if @character.update(character_params)
      redirect_to @character
    else
      render 'edit'
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.narigraphs.each {|n| n.update(character_name: @character.name)}
    game = @character.player.game
    @character.destroy
    redirect_to game_path(game)
  end

  def set_active
    character = Character.find(params[:id])
    if character.set_active_character
      redirect_to character_path(character)
    else
      flash[:alert] = "Could not set active. Sucks for you."
      redirect_to character_path(character)
    end
  end

  def join_party
    character = Character.find(params[:id])
    if character.set_party_member
      redirect_to character_path(character)
    else
      flash[:alert] = "Could not join party. No one likes you."
      redirect_to character_path(character)
    end
  end

  private
  def character_params
    params.require(:character).permit(:name, :char_data)
  end

  helper_method :player
  def player
    @player if defined?(@player)
    @player = Player.find_by(user_id: current_user.id, game_id: params[:game_id])
  end
end
