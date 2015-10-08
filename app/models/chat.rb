class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def timestamp
    created_at.strftime('%b %-d %l:%M')
  end

  def self.create_with_user_and_game(user, game, params)
    chat = Chat.new()
    chat.username = user.username
    chat.game_id = game.id
    chat.text = params["text"]
    chat.save
  end
end
