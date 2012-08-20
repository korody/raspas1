class AddTypeToOrigins < ActiveRecord::Migration
  def change
    add_column :origins, :type, :string
  end
end
