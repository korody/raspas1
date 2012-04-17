class AddPublishedToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :published, :boolean, default: false
  end
end
