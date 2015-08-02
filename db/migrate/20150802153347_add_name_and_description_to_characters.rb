class AddNameAndDescriptionToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :name, :string
    add_column :characters, :description, :text
  end
end
