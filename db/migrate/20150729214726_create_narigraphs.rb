class CreateNarigraphs < ActiveRecord::Migration
  def change
    create_table :narigraphs do |t|
      t.string :character_name
      t.text :text

      t.timestamps null: false
    end
  end
end
