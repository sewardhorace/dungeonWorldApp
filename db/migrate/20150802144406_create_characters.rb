class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.boolean :is_active, default: false
      t.boolean :is_party_member, default: false
      t.integer :role, default: 0
      t.json :char_data, default: '{}'
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true

      t.timestamps null: false
    end
  end
end
