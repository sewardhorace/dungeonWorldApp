class AddNameToNarigraphs < ActiveRecord::Migration
  def change
    add_column :narigraphs, :character_name, :string
  end
end
