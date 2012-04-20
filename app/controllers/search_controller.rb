class SearchController < ApplicationController

  def index
    @tags = Tag.search(params[:search].downcase)
    @authors = Author.search(params[:search].titlecase)
    @users = User.search(params[:search].titlecase)
    @microposts = Micropost.search(params[:search].downcase)
    @micropost = Micropost.new
    @authors = Author.all(:order => 'authors.created_at DESC')
    @tags = Tag.all(:order => 'tags.created_at DESC')
  end

end