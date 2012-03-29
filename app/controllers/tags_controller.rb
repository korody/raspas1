class TagsController < ApplicationController
	
	def index
	    @title = "temas"
	    @tags = Tag.paginate(:page => params[:page])
  	end

  	def show
	    @tag = Tag.find(params[:id])
	    @tags = Tag.all
	    @users = @tag.users
	    @authors = @tag.authors
	    @microposts = @tag.microposts.paginate(:page => params[:page])
	end

	def users
	    @title = "users"
	    @tag = Tag.find(params[:id])
	    @tag_users = @tag.users.all(:order => 'users.created_at DESC', :limit => 40)
	    @tags = @tag.users.paginate(:page => params[:page])
	    render 'show_users'
	end

	def authors
	    @title = "authors"
	    @tag = Tag.find(params[:id])
	    @tag_authors = @tag.authors.all(:order => 'authors.created_at DESC', :limit => 40)
	    @tags = @tag.authors.paginate(:page => params[:page])
	    render 'show_authors'
	end
end
