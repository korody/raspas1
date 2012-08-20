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
      if user.salt.blank?
        create_salt = SecureRandom.urlsafe_base64
        user.update_attributes(remember_token: create_salt)
      end
      signin user
      redirect_back_or root_path
      #flash.now[:success] = "Olá! Sentindo-se inspirado hoje?"
    else
      user = User.create_with_omniauth(auth)
      if user.save
        unless email.blank?
          NotificationsMailer.registration_confirmation(user).deliver
          signin user
          redirect_back_or user
          flash[:success] = "Olá #{user.name}! Seja bem-vindo à sua coleção de raspas!"
        else
          signin user
          redirect_back_or edit_user_path(current_user)
          flash[:notice] = "Só faltou um e-mail para finalizarmos o cadastro. O twitter voou antes de nos contar!"
        end  
      else
        redirect_to signin_path, notice: "Ops! Parece que o twitter está meio avoado hoje. Por favor, tente novamente."
      end  
    end 
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end