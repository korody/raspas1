class AddImageToOrigins < ActiveRecord::Migration
  def change
    rename_column :origins, :cover, :image
  end
end
