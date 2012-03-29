# encoding: utf-8
class AuthorsController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :new]

  def index
    @title = "All authors"
    @authors = Author.all
    @authors = Author.paginate(:page => params[:page])
  end

 def show
    @author = Author.find(params[:id])
    @microposts = @author.microposts.paginate(:page => params[:page])
    @tags = @author.tags.all(:order => 'tags.created_at DESC')
    @users = @author.users.all(:order => 'users.created_at DESC')
  end
  
  def new
  	@author = Author.new
    @micropost = Micropost.new
    @title = "Sign up"
  end

  def create
    @author = Author.new(params[:author])
    if @author.save
      flash[:success] = "Perfil para #{@author.name} criado com sucesso!"
      redirect_to @author
    else
      @title = "cadastre-se"
      render 'new'
      #Reset @user.password.???
    end
  end

  def edit
    @author = Author.find(params[:id])
    @title = "editar"
  end

  def update
  	@author = Author.find(params[:id])
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
      @title = "tags"
      @author = Author.find(params[:id])
      @author_tags = @author.tags.all(:order => 'tags.created_at DESC', :limit => 20)
      @authors = @author.tags.paginate(:page => params[:page])
      render 'show_tags'
  end

  def fans
    @title = "Fans"
    @author = Author.find(params[:id])
    @authors_fans = @author.fans.all(:order => 'users.created_at DESC', :limit => 40)
    @authors = @author.fans.paginate(:page => params[:page])
    render 'show_fans'
  end

  def idols
    @title = "Idols"
    @author = Author.find(params[:id])
    @authors = @author.idols.paginate(:page => params[:page])
    render 'show_idols'
  end

  def users
    @title = "users"
    @author = Author.find(params[:id])
    @authors_users = @author.users.all(:order => 'users.created_at DESC')
    @authors = @author.users.paginate(:page => params[:page])
    render 'show_users'
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