class UpdateForeignKeysForNewRelations < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.integer :gm_id, index: true
    end

    change_table :characters do |t|
      t.remove :player_id
    end

    change_table :narigraphs do |t|
      t.remove :game_id
    end

    create_table :users_games, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :user, index: true
    end

    drop_table :players

  end
end
