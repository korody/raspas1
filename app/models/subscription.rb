class Subscription < ActiveRecord::Base
	attr_accessible :author_id

	belongs_to :user
	belongs_to :author

	validates :user_id, :presence => true
  	validates :author_id, :presence => true
end
