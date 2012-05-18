ActiveAdmin.register Favourite do
  index do
		column :id
		column :user_id
		column :micropost_id
		column :author_id
		column :poster_id
		default_actions
	end  
end
