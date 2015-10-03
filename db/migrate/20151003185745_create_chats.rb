class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :username
      t.text :text
      t.integer :user_id, index: true
      t.integer :game_id, index: true

      t.timestamps null: false
    end
  end
end
