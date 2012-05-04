ActiveAdmin.register Tagging do
	index do
		column :micropost
		column :tag
		default_actions
	end  
end
