module Api
  module V1
    class GameplayController < Api::V1::ApiController
      helper_method :game
      
      def klass_index
        render json: Klass.all.as_json
      end

      def chat_index
        render json: game.chats.order('created_at ASC').as_json
      end
      def chat_create
        if chat = Chat.create_with_user_and_game_id(current_user, game.id, chat_params)
          head :no_content
        else
          render status: 500
        end
      end

      def game
        @game if defined?(@game)
        @game = Game.find_by(id: params[:game_id])
      end

      private
      def chat_params
        params.require(:chat).permit(:text)
      end
    end
  end
end
