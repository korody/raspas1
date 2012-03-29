class AddAuthorIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :author_id, :integer
  end
end
