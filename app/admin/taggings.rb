ActiveAdmin.register Tagging do
	index do
		column :micropost_id
		column :tag_id
		default_actions
	end  
end
