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

      def roll_params
        params.require(:roll).permit(:number_of_dice, :number_of_sides, :modifier)
      end
    end
  end
end
