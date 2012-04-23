class FavouritesController < ApplicationController

	  def destroy
	    Favourite.find(params[:id]).destroy
	    flash[:success] = "Raspa removida dos seus favoritos!"
	    redirect_to current_user
	  end


end
