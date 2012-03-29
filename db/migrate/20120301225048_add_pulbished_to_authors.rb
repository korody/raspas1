class AddPulbishedToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :published, :boolean, default: true
  end
end
