  class PagesController < ApplicationController
  
  def home
    @title = "casa"
    @user = User.new
    @feed_items = Micropost.all(:order => 'microposts.created_at DESC', :limit => 20)
    @new_micropost = Micropost.new
    @authors = Author.all(:order => 'authors.created_at DESC')
    @users = User.all(:order => 'users.created_at DESC')
    @tags = Tag.all(:order => 'tags.created_at DESC')
  end

  def about
  	@title = "saiba mais"
    @new_micropost = Micropost.new
  end
end