ActiveAdmin.register User do
  index do
  	column :id
  	column :name
  	column :email
  	column :job
  	column :photo_content_type	
  	column :admin
  	default_actions
  end
end
