class AddChatIdToUserAndGame < ActiveRecord::Migration
  def change
    add_column :users, :chat_id, :integer
    add_column :games, :chat_id, :integer
  end
end
