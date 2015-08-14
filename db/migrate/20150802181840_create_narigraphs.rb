class CreateNarigraphs < ActiveRecord::Migration
  def change
    create_table :narigraphs do |t|
      t.integer :character_id
      t.integer :game_id
      t.text :text

      t.timestamps null: false
    end
  end
end
