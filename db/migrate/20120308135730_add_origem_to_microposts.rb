class AddOrigemToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :origem, :string
  end
end
