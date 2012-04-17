class AutocompleteController < ApplicationController

	def index
		@authors = Author.order(:name).where("name like ?", "%#{params[:term].titlecase}%")
	    render json: @authors.map(&:name)	
	end

end
