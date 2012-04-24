class AddAuthorIdToFavourites < ActiveRecord::Migration
  def change
    add_column :favourites, :author_id, :integer
  end
end
