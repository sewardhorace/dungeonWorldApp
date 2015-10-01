module Api
  module V1
    class NarigraphsController < Api::V1::ApiController
      # before_action :require_active_character, only:[:create]
      helper_method :game, :player

      def index
        render json: game.narigraphs.order('created_at ASC').as_json
        # @narigraphs = game.narigraphs.paginate(page: params[:page], per_page: 10).order('created_at DESC')
        # @narigraph = Narigraph.new
      end

      def create
        if narigraph = Narigraph.create_with_character_and_game_id(character, game.id, narigraph_params)
          head :ok
        else
          render status: 500
        end
      end

      def move_roll
        roll = Roll.new(roll_params)
        narigraph = Narigraph.new(narigraph_params)
        narigraph.text = roll.description
        narigraph.auto_generated = true
        if narigraph.save
          redirect_to game_narigraphs_path
        else
          render status: 500
        end
      end

      def player
        @player if defined?(@player)
        @player = Player.find_by(user_id: current_user.id, game_id: params[:game_id])
      end

      def character
        character = player.active_party_member
      end

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

    end
  end
end
