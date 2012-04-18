class CreateEleita < ActiveRecord::Migration
  def change
    create_table :eleita do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
  end
end
