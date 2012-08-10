class AddOriginIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :origin_id, :integer
  end
end
