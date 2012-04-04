  # encoding: utf-8
  class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create, :search, :index, :following, :followers]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @micropost = Micropost.new
    @microposts = @user.microposts.paginate(:page => params[:page])
    @tags = @user.tags.all(:order => 'tags.created_at DESC')
    @authors = @user.authors.all(:order => 'authors.created_at DESC')
    @title = @user.name
  end

  def tags
      @title = "tags"
      @user = User.find(params[:id])
      @user_tags = @user.tags.all(:order => 'tags.created_at DESC', :limit => 20)
      @users = @user.tags.paginate(:page => params[:page])
      render 'show_tags'
  end

  def new
  	@user = User.new
    @title = "Sign up"
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
      #Reset @user.password.???
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "editar"
  end

  def update
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
    flash[:success] = "Obrigado por honrar-nos com suas raspas! Até logo."
    redirect_to root_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users_following = @user.following.all(:order => 'users.created_at DESC', :limit => 40) 
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users_followers = @user.followers.all(:order => 'users.created_at DESC', :limit => 40)
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_followers'
  end

  def idols
    @title = "Idols"
    @user = User.find(params[:id])
    @users_idols = @user.idols.all(:order => 'authors.created_at DESC', :limit => 40)
    @users = @user.idols.paginate(:page => params[:page])
    render 'show_idols'
  end

  def authors
    @title = "authors"
    @user = User.find(params[:id])
    @users_authors = @user.authors.all(:order => 'authors.created_at DESC', :limit => 40)
    @users = @user.authors.paginate(:page => params[:page])
    render 'show_authors'
  end

  def fans
    @title = "Fans"
    @user = User.find(params[:id])
    @authors_fans = @author.fans.all(:order => 'users.created_at DESC', :limit => 40)
    @authors = @author.fans.paginate(:page => params[:page])
    render 'show_fans'
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