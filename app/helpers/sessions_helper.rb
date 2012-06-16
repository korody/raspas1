# encoding: utf-8
module SessionsHelper

  def home
    #if signed_in?
      #request.fullpath == home_path
    #else  
      request.fullpath == root_path #|| home_path
    #end
  end	

  def current_user
    @current_user ||= User.find_by_salt(cookies[:remember_token]) if cookies[:remember_token]
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.salt
    self.current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

   def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Opa! Vamos por partes. Você já conectou-se ao raspas?"
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  private

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end
  
end