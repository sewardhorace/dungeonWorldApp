class CreateNarigraphs < ActiveRecord::Migration
  def change
    create_table :narigraphs do |t|
      t.integer :character_id
      t.string :character_name
      t.boolean :auto_generated, default: false
      t.text :text

      t.timestamps null: false
    end
  end
end
