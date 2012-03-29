class RemoveAuthorIdToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :author_id
  end

  def down
    add_column :users, :author_id, :string
  end
end
