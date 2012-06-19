ActiveAdmin.register Micropost, path: "raspas" do
  
  scope :PUBLISHED
  scope :UNPUBLISHED

  index do
  	column :id
  	column :user
  	column :author
  	column :content
  	column :tag
  	column :origem
  	column :published
  	default_actions
  end
end
