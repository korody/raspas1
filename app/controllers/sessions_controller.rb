# encoding: utf-8
class SessionsController < ApplicationController

	def new
		@title = "Sign in"
	end

	def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_back_or user
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:success] = "Obrigado por enriquecer nosso acervo! Nos vemos em breve." 
  end

end