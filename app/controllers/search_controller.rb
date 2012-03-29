class SearchController < ApplicationController

  def index
    @tags = Tag.search(params[:search].downcase)
    @authors = Author.search(params[:search].capitalize)
    @users = User.search(params[:search].capitalize)
    @microposts = Micropost.search(params[:search].downcase)
  end

end