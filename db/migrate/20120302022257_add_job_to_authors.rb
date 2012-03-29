class AddJobToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :job, :string
  end
end
