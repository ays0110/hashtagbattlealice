class CreateBattlepoints < ActiveRecord::Migration
  def change
    create_table :battlepoints do |t|
      t.integer :battle_id
      t.integer :hashtag
      t.integer :count

      t.timestamps
    end
  end
end
