class FavouritesController < ApplicationController 

	def destroy
		@favourite = Favourite.find(params[:id]).destroy
		flash[:success] = "Raspa removida de suas favoritas!"
		redirect_back_or favourites_user_path(current_user)
	end

end
