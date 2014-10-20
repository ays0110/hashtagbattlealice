class RenameCount < ActiveRecord::Migration
  def change
      rename_column :battlepoints, :count, :tweetcount

  end
end
