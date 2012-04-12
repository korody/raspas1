class SearchController < ApplicationController

  def index
    @tags = Tag.search(params[:search].downcase)
    @authors = Author.search(params[:search].titlecase)
    @users = User.search(params[:search].titlecase)
    @microposts = Micropost.search(params[:search].downcase)
  end

end