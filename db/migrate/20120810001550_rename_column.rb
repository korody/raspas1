class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :microposts, :origem, :origin_type
  end
end
