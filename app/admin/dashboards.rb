# encoding: utf-8
ActiveAdmin::Dashboards.build do

  section 'ÚLTIMAS RASPAS' do
    table_for Micropost.order("created_at desc").limit(20) do
      column :id do |micropost|
        link_to micropost.id, [:admin, micropost]
      end
      column :user
      column :author
      column :content do |micropost|
        link_to micropost.content, [:admin, micropost]
      end
      column :tag_names
      column :published
    end
    strong { link_to "TODAS RASPAS", admin_microposts_path }
  end

  section 'ÚLTIMOS PENSADORES' do
    table_for Author.order("created_at desc").limit(20) do
      column :id do |author|
        link_to author.id, [:admin, author]
      end
      column :name do |author|
        link_to author.name, [:admin, author]
      end
      column :job
      column :bio
      column :published
    end
    strong { link_to "TODOS PENSADORES", admin_authors_path }
  end

   section 'ÚLTIMOS USUÁRIOS' do
    table_for User.order("created_at desc").limit(20) do
      column :id do |user|
        link_to user.id, [:admin, user]
      end
      column :name do |user|
        link_to user.name, [:admin, user]
      end
      column :job
      column :bio
    end
    strong { link_to "TODOS USUÁRIOS", admin_authors_path }
  end

  section 'ÚLTIMOS TEMAS' do
    table_for Tags.order("created_at desc").limit(20) do
      column :id do |tag|
        link_to tag.id, [:admin, tag]
      end
      column :name do |tag|
        link_to user.name, [:admin, tag]
      end
    end
    strong { link_to "TODOS TEMAS", admin_tags_path }
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
