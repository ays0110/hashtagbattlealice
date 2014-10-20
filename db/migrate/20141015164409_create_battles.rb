class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string :hashtag1
      t.string :hashtag2
      t.integer :user_id
      t.integer :since_number
      t.integer :status
      t.datetime :ends_at

      t.timestamps
    end
  end
end
