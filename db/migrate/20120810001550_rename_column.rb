class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :microposts, :origin, :origin_type
  end
end
