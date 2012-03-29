class RemoveTipoToJobs < ActiveRecord::Migration
  def up
    remove_column :jobs, :tipo
  end

  def down
    add_column :jobs, :tipo, :string
  end
end
