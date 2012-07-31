class SearchController < ApplicationController

  def index
    # @tags = Tag.search(params[:search])
    @authors = Author.text_search(params[:query])
    # @users = User.search(params[:search])
    # @microposts = Micropost.search(params[:search])
    @new_micropost = Micropost.new
  end
end