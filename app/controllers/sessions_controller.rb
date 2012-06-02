# encoding: utf-8
class SessionsController < ApplicationController

  def new
    @title = "entrar"
    @new_micropost = Micropost.new
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    email = auth['info']['email']
    if user
      session[:user_id] = user.id
      redirect_back_or user
      flash[:success] = "Olá! Sentindo-se inspirado hoje?"
    else
      user = User.create_with_omniauth(auth)
      if user.save
        if !email.blank?
          NotificationsMailer.registration_confirmation(user).deliver
          session[:user_id] = user.id
          redirect_back_or user
          flash[:success] = "Olá #{user.name}! Seja bem-vindo à sua coleção de raspas!"
        else
          session[:user_id] = user.id
          redirect_back_or edit_user_path(current_user)
          flash[:notice] = "Ops! Faltou o seu e-mail... Diga-nos qual é para finalizarmos o seu cadastro."
        end  
      else
        session[:user_id] = auth.except('extra')
        redirect_to new_user_url
      end  
    end 
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end