ActiveAdmin.register Favourite do
  index do
		column :id
		column :user_id
		column :micropost_id
		column :author_id
		column :poster_id
		default_actions
	end

	form do |f|
	    f.inputs "Favourites" do
	    	column :id
	    	column :user_id
	    	column :micropost_id
	    	column :poster_id
	    end
	    f.buttons
  	end  
end

