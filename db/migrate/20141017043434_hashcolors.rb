class Hashcolors < ActiveRecord::Migration
  def change
      add_column :battles, :hash1color, :int
      add_column :battles, :hash2color, :int
  end
end
