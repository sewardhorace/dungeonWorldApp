class NarigraphsController < ApplicationController
  #before_action :require_character, only:[:create]

  def index
    @narigraphs = Narigraph.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @narigraph = Narigraph.new
  end

  def create
    respond_to do |format|
      user = current_user
      #user = User.find(params[:user_id])
      puts params
      game = Game.find(params[:id])
      @narigraph = Narigraph.new(narigraph_params, game_id: game.id)
      if @narigraph.save
        flash[:success] = 'successfil'
        Pusher['test_channel'].trigger_async('posted', {
          new_entry: @narigraph.as_json
        })
        format.html {redirect_to narigraphs_path}
        format.js
      else
        flash[:error] = 'nope erer'
      end

    end
  end

  private
    def narigraph_params
      params.require(:narigraph).permit(:character_name, :text)
    end
end
