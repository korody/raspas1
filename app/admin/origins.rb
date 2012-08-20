ActiveAdmin.register Origin do
  index do
    column :id
    column :name
    column :type
    column :content
    column :date
    column :link
    column :user_id
    column :author_id
    column :image
    default_actions
  end
end
