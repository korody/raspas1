class SearchController < ApplicationController

  def index
  	@title = "busca por #{(params[:query])}"
    @tags = Tag.search(params[:query])
    @authors = Author.search(params[:query])
    @users = User.search(params[:query])
    @microposts = Micropost.search(params[:query])
    @origins = Origin.search(params[:query])
    @new_micropost = Micropost.new
  end
end