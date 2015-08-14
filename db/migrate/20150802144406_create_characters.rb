class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    add_column :characters, :player_id, :integer
    add_index :characters, :player_id

    add_column :characters, :is_active, :boolean, default: false
  end
end
