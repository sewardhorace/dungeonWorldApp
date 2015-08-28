class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string :name
      t.json :names
      t.json :looks
      t.integer :damage
      t.integer :base_hp
      t.json :alignment

      t.timestamps null: false
    end
  end
end
