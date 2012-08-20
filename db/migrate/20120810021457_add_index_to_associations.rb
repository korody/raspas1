class AddIndexToAssociations < ActiveRecord::Migration
  def change
    add_index :microposts, [:origin_type, :origin_id]
  end
end
