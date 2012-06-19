ActiveAdmin.register Tagging do
	index do
		column :micropost do |micropost|
	        link_to micropost.id, [:admin, micropost]
			link_to micropost.content, [:admin, micropost]
	      end
		column :tag
		default_actions
	end

	form do |f|
	    f.inputs "Taggings" do
	      f.inputs :micropost do |micropost|
	        link_to micropost.id, [:admin, micropost]
			link_to micropost.content, [:admin, micropost]
	      end
		f.inputs :tag
	    end
	    f.buttons
  	end
end
