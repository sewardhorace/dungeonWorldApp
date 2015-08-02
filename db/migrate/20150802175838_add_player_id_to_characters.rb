class AddPlayerIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :player_id, :integer
    add_index :characters, :player_id
  end
end
