ActiveAdmin.register Tagging do
	index do
		column :micropost do |micropost|
	        link_to micropost.id, [:admin, micropost]
	      end
		column :tag
		default_actions
	end

	form do |f|
	    f.inputs "Taggings" do
			f.inputs :micropost
			f.inputs :tag
	    end
	    f.buttons
  	end
end
