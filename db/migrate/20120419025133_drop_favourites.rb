class DropFavourites < ActiveRecord::Migration
  def self.down
    drop_table :favourites do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
  end
end

