class CreateNarigraphs < ActiveRecord::Migration
  def change
    create_table :narigraphs do |t|
      t.integer :player_id
      t.text :text

      t.timestamps null: false
    end
  end
end
