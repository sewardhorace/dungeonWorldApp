class AddAliveToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :is_alive, :boolean, default: true
  end
end
