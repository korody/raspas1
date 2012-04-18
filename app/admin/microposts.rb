ActiveAdmin.register Micropost do
  
  scope :published	

  index do
  	column :id
  	column :content
  	column :tag_names
  	column :user_id
  	column :author_id
  	column :origem
  	column :published
  	default_actions
  end
end
