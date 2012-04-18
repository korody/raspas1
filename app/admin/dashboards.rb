ActiveAdmin::Dashboards.build do

  section 'RECENT QUOTES' do
    table_for Micropost.order("created_at desc").limit(10) do
      column :id do |micropost|
        link_to micropost.id, [:admin, micropost]
      end
      column :user
      column :author
      column :content
      column :tag_names
      column :published
    end
    strong { link_to "ALL QUOTES", admin_microposts_path }
  end

  section 'RECENT AUTHORS' do
    table_for Author.order("created_at desc").limit(10) do
      column :id do |author|
        link_to author.id, [:admin, author]
      end
      column :name
      column :job
      column :bio
      column :published
    end
    strong { link_to "ALL AUTHORS", admin_authors_path }
  end

   section 'RECENT USERS' do
    table_for User.order("created_at desc").limit(10) do
      column :id do |user|
        link_to user.id, [:admin, user]
      end
      column :name
      column :job
      column :bio
    end
    strong { link_to "ALL USERS", admin_authors_path }
  end

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
