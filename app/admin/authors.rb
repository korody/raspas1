ActiveAdmin.register Author do

	scope :PUBLISHED
  	scope :UNPUBLISHED

	index do
	  	column :id
	  	column :name
	  	column :job
	  	column :image
	  	column :published, as: 'boolean', select: 'check_box'
	  	default_actions
  	end  
end
