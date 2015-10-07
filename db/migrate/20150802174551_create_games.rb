class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :description
      t.integer :gm_id, index: true
      t.timestamps null: false
    end
  end
end
