# encoding: utf-8
class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :favourites]
  before_filter :authorized_user, :only => :destroy

  def index
    @title = "microposts"
    @microposts = Micropost.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
  end

  def show
    @micropost = Micropost.find(params[:id])
    @new_micropost = Micropost.new
    @tags = @micropost.tags
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      if @micropost.author
        redirect_to @micropost.author
        flash[:success] = "Você adicionou um pensamento de #{@micropost.author.name}! Obrigado."
      else
        redirect_back_or current_user
      end
    else
      flash[:error] = "Ops! Algo deu errado. Você lembrou de escrever a raspa?"
      redirect_back_or current_user
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or current_user
  end

  def favourites
    original_micropost = Micropost.find(params[:id])
    if original_micropost
      favourite_micropost = current_user.favourites.build(micropost_id: original_micropost.id)
      if favourite_micropost.save
        redirect_to favourites_user_path(current_user)
        flash[:success] = "Raspa adicionada às suas favoritas!"   
      else
        redirect_to user_path(current_user), notice: new_micropost.errors.full_messages
      end
    else
      redirect_back_or current_user
      flash[:error] = "A raspa mencionada não existe mais!"
    end
  end

  private

    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end