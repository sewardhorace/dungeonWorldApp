module Api
  module V1
    class GameplayController < Api::V1::ApiController

      def klass_index
        render json: Klass.all.as_json
      end

      # def game
      #   @game if defined?(@game)
      #   @game = Game.find_by(id: params[:game_id])
      # end
    end
  end
end
