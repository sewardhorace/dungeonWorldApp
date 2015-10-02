class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string :name
      t.json :klass_data

      t.timestamps null: false
    end
  end
end
