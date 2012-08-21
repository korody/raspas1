# encoding: utf-8
class TagsController < ApplicationController
	
	def index
	    @title = "temas de  frases e pensamentos"
  		@new_micropost = Micropost.new
	    @tags = Tag.all(order: :name)
  	end

  	def show
	    @tag = Tag.find(params[:id])
	    @title = "#{@tag.name}"
	    @tags = Tag.all(:order => 'tags.created_at DESC')
	    @users = @tag.users(:order => 'tags.created_at DESC')
	    @authors = @tag.authors(:order => 'tags.created_at DESC')
	    @microposts = @tag.microposts.paginate(:page => params[:page])
	    @new_micropost = Micropost.new
	end

	def autocomplete
	    @tags = Tag.order(:name).search("%#{params[:term]}%")
   		render json: @tags.map(&:name) 
   	end

   	def users
      @tag = Tag.find(params[:id])
	  @title = "usuários sobre #{@tag.name}"
      @users = @tag.users.paginate(:page => params[:page])
      @new_micropost = Micropost.new
      render 'show_users'
  	end

  	def authors
      @tag = Tag.find(params[:id])
	  @title = "pensadores sobre #{@tag.name}"
      @authors = @tag.authors.paginate(:page => params[:page])
      @new_micropost = Micropost.new
      render 'show_authors'
  	end		
end
