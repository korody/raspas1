class PagesController < ApplicationController
  
  def home
    @title = "casa"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
    else
      @user = User.new
      @authors = Author.all
      @users = User.all
      @tags = Tag.all(:order => 'tags.created_at DESC')
      @feed_items = Micropost.all(:order => 'microposts.created_at DESC', :limit => 20)
    end
  end

  def about
  	@title = "conceito"
  end
end