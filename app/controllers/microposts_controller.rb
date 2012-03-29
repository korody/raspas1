# encoding: utf-8
class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :reaspas]
  before_filter :authorized_user, :only => :destroy

  def index
    @title = "microposts"
    @microposts = Micropost.paginate(:page => params[:page])
    @tags = Tag.all
    @authors = Author.all
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      if @micropost.author
        redirect_to @micropost.author
        flash[:success] = "Você adicionou um pensamento de #{@micropost.author.name}. Obrigado!"
      else
        redirect_to current_user
      end
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or current_user
  end

  def show
      @micropost = Micropost.find(params[:id])
      @microposts = Micropost.find(:all)
      @microposts = Micropost.paginate(:page => params[:page])
      @tags = @micropost.tags
  end

  ####### NEEDS WORK ON ###########

  def reaspa
    micropost = current_user.microposts.build(params[:micropost])
    if @icropost.save
      redirect_back_or root_path
      flash[:notice] = "Reaspa concluída! A raspa escolhida foi compartilhada."
    end
  end

  ####################################

  private

    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end