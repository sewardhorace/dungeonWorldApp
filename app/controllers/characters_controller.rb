class CharactersController < ApplicationController
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
    @character = current_user.characters.create(character_params)
    if @character.save
      redirect_to @character
    else
      redirect_to 'new'
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
end
