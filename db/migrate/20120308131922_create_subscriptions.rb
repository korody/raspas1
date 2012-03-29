class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :author_id

      t.timestamps
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :author_id
    add_index :subscriptions, [:user_id, :author_id], :unique => true
  end

  def self.down
    drop_table :subscriptions
  end
end