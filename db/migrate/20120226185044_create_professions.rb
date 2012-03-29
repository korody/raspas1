class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
