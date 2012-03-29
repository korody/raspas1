class AddOriginToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :origin, :string
  end
end
