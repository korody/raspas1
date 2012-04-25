  class PagesController < ApplicationController
  
  def home
    @title = "casa"
    @user = User.new
    @feed_items = Micropost.all(:order => 'microposts.created_at DESC', :limit => 20)
    @micropost = Micropost.new
    @microposts = Micropost.find(params[:id])
    @authors = Author.all(:order => 'authors.created_at DESC')
    @users = User.all(:order => 'users.created_at DESC')
    @tags = Tag.all(:order => 'tags.created_at DESC')
  end

  def about
  	@title = "conceito"
  end
end