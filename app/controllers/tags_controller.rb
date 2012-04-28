class TagsController < ApplicationController
	
	def index
	    @title = "temas"
	    @tags = Tag.paginate(:page => params[:page])
	    @tags = Tag.order(:name).where("name like ?", "%#{params[:term].titlecase}%")
   		render json: @tags.map(&:name) 
  	end

  	def show
	    @tag = Tag.find(params[:id])
	    @tags = Tag.all(:order => 'tags.created_at DESC')
	    @users = @tag.users(:order => 'tags.created_at DESC')
	    @authors = @tag.authors(:order => 'tags.created_at DESC')
	    @microposts = @tag.microposts.paginate(:page => params[:page])
	    @micropost = Micropost.new
	end

end
