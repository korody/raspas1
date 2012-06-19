ActiveAdmin.register Tagging do
	index do
		column :micropost do |micropost|
	        link_to micropost.id, [:admin, tagging]
	      end
		column :tag
		default_actions
	end  
end
