  # encoding: utf-8
  class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create, :search, :index, :following, :followers]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @title = "usuários"
    @users = User.all(order: :name)
    # @users = User.paginate(:page => params[:page])
    @new_micropost = Micropost.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @new_micropost = Micropost.new
    @microposts = @user.favo.paginate(:page => params[:page])
    @tags = @user.tags.all(:order => 'tags.created_at DESC')
    @authors = @user.authors.all(:order => 'authors.created_at DESC')
  end

  def feed
    @title = "mural"
    @user = User.find(params[:id])
    @new_micropost = Micropost.new        
    @feed_items = current_user.feed.paginate(:page => params[:page])
    @feed_intro = Micropost.all(order: 'microposts.created_at DESC', limit: 10)
    @authors_intro = Author.all(order: 'authors.created_at DESC', limit: 10)
    @users_eleitas = @user.eleitas.all(:order => 'microposts.created_at DESC', :limit => 40)
    @users_following = @user.following.all(:order => 'users.created_at DESC', :limit => 40) 

  end

  def tags
      @title = "temas"
      @user = User.find(params[:id])
      @user_tags = @user.tags.all(:order => 'tags.created_at DESC', :limit => 20)
      @users = @user.tags.paginate(:page => params[:page])
      @new_micropost = Micropost.new
      @authors = Author.all
      @tags = Tag.all
      render 'show_tags'
  end

  def new
  	@user = User.new
    @title = "cadastre-se"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Seja bemvindo à sua coleção de raspas! Divirta-se."
      redirect_to @user
    else
      @title = "cadastre-se"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "editar"
    @new_micropost = Micropost.new
  end

  def update
    @new_micropost = Micropost.new
    if @user.update_attributes(params[:user])
      flash[:success] = "Perfil atualizado com sucesso! Veja aí as alterações."
      redirect_to @user
    else
      @title = "editar"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    sign_out
    flash[:success] = "Obrigado por honrar-nos com suas raspas! Até logo."
    redirect_to root_path
  end

  def following
    @title = "seguindo"
    @user = User.find(params[:id])
    @users_following = @user.following.all(:order => 'users.created_at DESC', :limit => 40) 
    @users = @user.following.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    render 'show_follow'
  end

  def followers
    @title = "seguidores"
    @user = User.find(params[:id])
    @users_followers = @user.followers.all(:order => 'users.created_at DESC', :limit => 40)
    @users = @user.followers.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    render 'show_followers'
  end

  def idols
    @title = "ídolos"
    @user = User.find(params[:id])
    @users_idols = @user.idols.all(:order => 'authors.created_at DESC', :limit => 40)
    @users = @user.idols.paginate(:page => params[:page])
    @author_favourites = @user.authors
    @new_micropost = Micropost.new
    render 'show_idols'
  end

  def authors
    @title = "pensadores"
    @user = User.find(params[:id])
    @users_authors = @user.authors.all(:order => 'authors.created_at DESC', :limit => 40)
    @users = @user.authors.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    render 'show_authors'
  end

  def fans
    @title = "fãs"
    @user = User.find(params[:id])
    @authors_fans = @author.fans.all(:order => 'users.created_at DESC', :limit => 40)
    @authors = @author.fans.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    render 'show_fans'
  end

  def favourites
    @title = "favoritas"
    @user = User.find(params[:id])
    @favourites = @user.favourites.all
    @user_eleitas = @user.eleitas
    @user_eleitas = @user.eleitas.paginate(:page => params[:page])
    @new_micropost = Micropost.new
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