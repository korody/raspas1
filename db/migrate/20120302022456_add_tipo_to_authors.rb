class AddTipoToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :tipo, :string
  end
end
