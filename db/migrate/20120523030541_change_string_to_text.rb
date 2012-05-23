class ChangeStringToText < ActiveRecord::Migration
  def change
	change_column :authors, :bio, :text, limit: nil
	change_column :users, :bio, :text, limit: nil
  end
end