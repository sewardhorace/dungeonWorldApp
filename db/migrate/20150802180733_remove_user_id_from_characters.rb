class RemoveUserIdFromCharacters < ActiveRecord::Migration
  def change
    remove_column :characters, :user_id
  end
end
