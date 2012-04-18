class RemovePublishedToAuthors < ActiveRecord::Migration
  def up
    remove_column :authors, :published
  end

  def down
    add_column :authors, :published, :boolean
  end
end
