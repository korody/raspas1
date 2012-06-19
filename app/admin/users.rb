ActiveAdmin.register User do
  index do
  	column :id
  	column :name
  	column :email
  	column :job
  	column :image
  	column :admin
  	default_actions
  end
end
