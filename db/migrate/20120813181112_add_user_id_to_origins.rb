class AddUserIdToOrigins < ActiveRecord::Migration
  def change
    add_column :origins, :user_id, :integer
  end
end
