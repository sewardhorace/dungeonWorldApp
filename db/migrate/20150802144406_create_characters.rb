class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name

      t.timestamps null: false
    end
    add_column :characters, :player_id, :integer
    add_index :characters, :player_id

    add_column :characters, :is_active, :boolean, default: false
    add_column :characters, :is_party_member, :boolean, default: false
  end
end
