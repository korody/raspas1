class Favourite < ActiveRecord::Base

	belongs_to :user
	belongs_to :author
	belongs_to :micropost
	belongs_to :poster, class_name: "User"
	
end
