class CreateUserGames < ActiveRecord::Migration
  def change
    create_table :user_games do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
