class RemoveOriginTypeToMicroposts < ActiveRecord::Migration
  def up
    remove_column :microposts, :origin_type
  end

  def down
    add_column :microposts, :origin_type, :string
  end
end
