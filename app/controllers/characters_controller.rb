class CharactersController < ApplicationController
  before_action :require_playing, only:[:create]
  before_action :require_character_owner, only:[:edit]

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
      puts '*' * 20
      redirect_to character_path(@character)
    else
      puts '&' * 20
      redirect_to new_game_character_path
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
    @character.destroy

    redirect_to characters_path
  end

  private
  def character_params
    params.require(:character).permit(:name, :description)
  end

  helper_method :player
  def player
    @player if defined?(@player)
    @player = Player.find_by(user_id: current_user.id, game_id: params[:game_id])
  end

end
