class CreateFavourites < ActiveRecord::Migration
  def self.up
    create_table :favourites do |t|
      t.string :user_id
      t.string :micropost_id

      t.timestamps
    end
    add_index :favourites, :user_id
    add_index :favourites, :micropost_id
    add_index :favourites, [:user_id, :micropost_id], :unique => true
  end

   def self.down
    drop_table :favourites
  end
end