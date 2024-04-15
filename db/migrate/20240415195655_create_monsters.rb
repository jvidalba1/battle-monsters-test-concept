class CreateMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :monsters do |t|
      t.string :image_url
      t.integer :attack
      t.integer :defense
      t.integer :hp
      t.integer :speed
      t.string :name

      t.timestamps
    end
  end
end
