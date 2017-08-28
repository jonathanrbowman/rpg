class CreateCharactersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.boolean :playable, null: false, default: true
      t.integer :user_id
    end
  end
end
