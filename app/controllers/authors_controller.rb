# encoding: utf-8
class AuthorsController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :new]

  def index
    @title = "All authors"
    @authors = Author.all
    @authors = Author.paginate(:page => params[:page])
    @micropost = Micropost.new
    @tags = Tag.all
  end

  def show
      @author = Author.find(params[:id])
      @microposts = @author.microposts.paginate(:page => params[:page])
      @users = @author.users.all
      @micropost = Micropost.new
      @authors = Author.all
      @tags = Tag.all
      @author_micropost = Micropost.find(params[:id])
  end
  
  def new
    @title = "novo pensador"
    @author = Author.new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @author = Author.new(params[:author])
    if @author.save
      flash[:success] = "Perfil para #{@author.name} criado com sucesso!"
      redirect_to @author
    else
      @title = "cadastre-se"
      render 'new'
    end
  end

  def edit
    @title = "editar pensador"
    @author = Author.find(params[:id])
    @micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
  end

  def update
  	@author = Author.find(params[:id])
    @micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    if @author.update_attributes(params[:author])
      flash[:success] = "Pensador atualizado com sucesso! Veja aí as alterações."
      redirect_to @author
    else
      @title = "editar"
      render 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = "Obrigado por honrar-nos com suas raspas! Até logo."
    redirect_to root_path
  end

    def tags
      @title = "temas"
      @author = Author.find(params[:id])
      @author_tags = @author.tags.all(:order => 'tags.created_at DESC', :limit => 20)
      @authors = @author.tags.paginate(:page => params[:page])
      @micropost = Micropost.new
      @authors = Author.all
      @tags = Tag.all
      render 'show_tags'
  end

  def fans
    @title = "fãs"
    @author = Author.find(params[:id])
    @authors_fans = @author.fans.all(:order => 'users.created_at DESC', :limit => 40)
    @authors = @author.fans.paginate(:page => params[:page])
    @micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    render 'show_fans'
  end

  def users
    @title = "users"
    @author = Author.find(params[:id])
    @authors_users = @author.users.all(:order => 'users.created_at DESC')
    @authors = @author.users.paginate(:page => params[:page])
    @micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    render 'show_users'
  end
       
  def favourites
    @title = "favoritas"
    @author = Author.find(params[:id])
    @author_eleitas = @author.eleitas
    @author_eleitas = @author.eleitas.paginate(:page => params[:page])
    @micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    render 'show_favourites'
  end

 private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end