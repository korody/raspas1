class FavouritesController < ApplicationController

	  def destroy
	    @favourite = Favourite.find(params[:id]).destroy
	    flash[:success] = "Raspa removida dos seus favoritos!"
	    redirect_back_or favourites_user_path(current_user)
	  end

end
