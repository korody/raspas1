# encoding: utf-8
module SessionsHelper

  def home
    if signed_in?
      request.fullpath == home_path
    else  
      request.fullpath == root_path
    end
  end

  def signin(user)
    cookies.permanent[:remember_token] = user.salt
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_salt(cookies[:remember_token]) if cookies[:remember_token]
  end

  def current_user?(user)
    user == current_user
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
    redirect_to signin_path, notice: "Por favor conecte-se para criar e favoritar raspas, criar e editar pensadores."
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