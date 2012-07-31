class SearchController < ApplicationController

  def index
    @tags = Tag.search(params[:query])
    @authors = Author.search(params[:query])
    @users = User.search(params[:query])
    @microposts = Micropost.search(params[:query])
    @new_micropost = Micropost.new
  end
end