class ChangeCharacterDataToJson < ActiveRecord::Migration
  def change
    add_column :characters, :char_data, :json, default: '{}'
    remove_column :characters, :str
    remove_column :characters, :dex
    remove_column :characters, :con
    remove_column :characters, :int
    remove_column :characters, :wis
    remove_column :characters, :cha
    remove_column :characters, :alignment
    remove_column :characters, :looks
    remove_column :characters, :description
  end
end
