  class PagesController < ApplicationController
  
  def home
    @title = "casa"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
      @feed_intro = Micropost.all(:order => 'microposts.created_at DESC', :limit => 20)
    else
      @user = User.new
      @authors = Author.all(:order => 'authors.created_at DESC')
      @users = User.all(:order => 'users.created_at DESC')
      @tags = Tag.all(:order => 'tags.created_at DESC')
      @feed_items = Micropost.all(:order => 'microposts.created_at DESC', :limit => 20)
    end
  end

  def about
  	@title = "conceito"
  end
end