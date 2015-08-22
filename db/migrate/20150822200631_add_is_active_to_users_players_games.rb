class AddIsActiveToUsersPlayersGames < ActiveRecord::Migration
  def change
    add_column :users, :is_active, :boolean, default: true
    add_column :players, :is_active, :boolean, default: true
    add_column :games, :is_active, :boolean, default: true
  end
end
