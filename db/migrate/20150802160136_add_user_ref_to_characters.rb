class AddUserRefToCharacters < ActiveRecord::Migration
  def change
    add_reference :characters, :user, index: true, foreign_key: true
  end
end
