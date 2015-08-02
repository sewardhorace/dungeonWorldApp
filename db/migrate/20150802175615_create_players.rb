class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id
      t.integer :role, default: 0
      t.integer :game_id

      t.timestamps null: false
    end

    add_index :players, :user_id
  end
end
