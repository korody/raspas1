class AddPosterToFavourites < ActiveRecord::Migration
  def change
    add_column :favourites, :poster_id, :integer
  end
end
