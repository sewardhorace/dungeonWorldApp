class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email

      t.timestamps null: false
    end

    add_column :users, :is_active, :boolean, default: true
  end
end
