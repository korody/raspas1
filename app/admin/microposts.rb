ActiveAdmin.register Micropost do
  
  scope :PUBLISHED
  scope :UNPUBLISHED

  index do
    column :id
    column :user
    column :author
    column :content
    column :origin_id
    column :published
    default_actions
  end
end
