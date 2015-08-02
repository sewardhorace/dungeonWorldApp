class AddUserRefToCharacters < ActiveRecord::Migration
  def change
    #nvm this already existed...
    #add_reference :characters, :user, index: true, foreign_key: true
  end
end
