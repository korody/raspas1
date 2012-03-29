class AddBornToUsers < ActiveRecord::Migration
  def change
    add_column :users, :born, :string
  end
end
