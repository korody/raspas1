# encoding: utf-8
class MicropostsController < ApplicationController
  before_filter :authenticate, only: [:create, :destroy, :favourites, :edit]
  before_filter :authorized_user, only: [:edit, :update, :destroy]

  def index
    @title = "Pensamentos e Frases"
    @microposts = Micropost.paginate(page: params[:page], order: "microposts.created_at DESC")
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
  end

  def show
    @micropost = Micropost.find(params[:id])
    @new_micropost = Micropost.new
    @tags = @micropost.tags
    @title = @micropost.content  
  end

  def create
    micropost = current_user.microposts.build(params[:micropost])
    if micropost.save
      if micropost.author
        redirect_to micropost.author
        flash[:success] = "Você adicionou um pensamento de #{micropost.author.name}! Obrigado."
      else
        redirect_back_or proprias_user_path(current_user)
        flash[:success] = "Adoramos ver raspas de sua própria autoria! Obrigado."
      end
    else
      content = micropost.content
      old_micropost = Micropost.find(:all, conditions: ['content LIKE ?', "#{content}"])
      if old_micropost
        redirect_to micropost_path(old_micropost)
        flash[:error] = "Ops! Sua raspa é repetida...favorite-a abaixo para guardá-la!"
      else
        redirect_to root_path
        flash[:error] = "Ops! Algo deu errado...parece que já temos esta raspa."
      end
    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
    @title = "editar raspa"
    @new_micropost = Micropost.new
  end

  def update
    @micropost = Micropost.find(params[:id])
    @new_micropost = Micropost.new
    if @micropost.update_attributes(params[:micropost])
      flash[:success] = "Raspa atualizada com sucesso!"
      redirect_to @micropost.user
    else
      @title = "editar raspa"
      render 'edit'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to current_user
  end

  def favouriters
    @title = "favoritaram"
    @micropost = Micropost.find(params[:id])
    @favouriters = @micropost.favouriters.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    render 'show_favouriters'
  end

  def random
    @random = Micropost.offset(rand(Micropost.count)).first
    redirect_to @random
  end

  private

    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end