module Api
  module V1
    class NarigraphsController < Api::V1::ApiController
      helper_method :game

      def index
        render json: game.narigraphs.order('created_at ASC').as_json
      end

      def create
        if narigraph = Narigraph.create_with_character(character, narigraph_params)
          head :no_content
        else
          render status: 500
        end
      end

      def character
        current_user.active_character_in_game(game)
      end

      def game
        @game if defined?(@game)
        @game = Game.find_by(id: params[:game_id])
      end

      private
      def narigraph_params
        params.require(:narigraph).permit(:game_id, :character_id, :text)
      end
    end
  end
end
