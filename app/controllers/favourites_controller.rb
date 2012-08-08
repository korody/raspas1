# encoding: utf-8
class FavouritesController < ApplicationController 

	 def criar
    original_micropost = Micropost.find(params[:id])
    @micropost = Micropost.find(params[:id])
	 	# original_micropost = Micropost.find(params[:favourite][:micropost_id])
    if original_micropost
      if original_micropost.author
        favourite_micropost = current_user.favourites.build(micropost_id: original_micropost.id, author_id: original_micropost.author.id, poster_id: original_micropost.user.id)
      else
        favourite_micropost = current_user.favourites.build(micropost_id: original_micropost.id, poster_id: original_micropost.user.id)
      end
      respond_to do |format|
        format.html { redirect_to :back }
        format.js { @micropost }
      end
      if favourite_micropost.save
        # redirect_to :back#favourites_user_path(current_user)
        # flash[:success] = "Raspa adicionada às suas favoritas!"   
        unless original_micropost.user.email.blank?
          NotificationsMailer.favourite_notice(favourite_micropost).deliver
        end
      else
        redirect_to user_path(current_user), notice: new_micropost.errors.full_messages
      end
    else
      redirect_back_or current_user
      flash[:error] = "A raspa mencionada não existe mais!"
    end
  end

	def destroy
		@favourite = Favourite.find(params[:id])
    @micropost = @favourite.micropost
    @favourite.destroy
    # redirect_to favourites_user_path(current_user)
		# flash[:success] = "Raspa removida de suas favoritas!"
		respond_to do |format|
      format.html { redirect_to :back }
      format.js { @micropost }
    end
	end
end