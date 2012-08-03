class Favourite < ActiveRecord::Base
  	attr_accessible :micropost_id, :author_id, :poster_id

	belongs_to :user
	belongs_to :author
	belongs_to :micropost, touch: true
	belongs_to :poster, class_name: "User"
	
end
