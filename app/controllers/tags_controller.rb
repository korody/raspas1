class TagsController < ApplicationController
	
	def index
	    @title = "temas"
	    @tags = Tag.paginate(:page => params[:page])
	    @tags = Tag.where("name like ?", "%#{params[:q]}%")
		  respond_to do |format|
		    format.html
		    format.json { render :json => @tags.map(&:attributes) }
  		end
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
