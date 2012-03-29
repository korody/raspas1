class SubscriptionsController < ApplicationController
	before_filter :authenticate

	def create
		@author = Author.find(params[:subscription][:author_id])
		current_user.fan!(@author)
		respond_to do |format|
	      format.html { redirect_to @author }
	      format.js
	    end
	end

	def destroy
		@author = Subscription.find(params[:id]).author
		current_user.unfan!(@author)
		respond_to do |format|
	      format.html { redirect_to @author }
	      format.js
	    end
	end
end
