class CreateBattles < ActiveRecord::Migration[7.1]
  def change
    create_table :battles do |t|
      t.integer :monsterA_id
      t.integer :monsterB_id
      t.integer :winner_id

      t.timestamps
    end
  end
end
