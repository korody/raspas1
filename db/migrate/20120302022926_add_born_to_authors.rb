class AddBornToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :born, :string
  end
end
