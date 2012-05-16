class FavouritesController < ApplicationController 

	def destroy
		@favourite = Favourite.find(params[:id]).destroy
		flash[:success] = "Raspa retirada de suas favoritas!"
		redirect_back_or favourites_user_path(current_user)
	end

	def favouriters
		@title = "favoritaram"
		@micropost = Micropost.find(params[:id])
		@favouriters = @micropost.favourites.all(:order => 'favourites.created_at DESC')
		@new_micropost = Micropost.new
		render 'show_favouriters'
	end
end
