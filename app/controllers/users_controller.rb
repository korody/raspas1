  # encoding: utf-8
  class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy, :feed]
  before_filter :correct_user, :only => [:edit, :update, :destroy, :feed]

  def index
    @title = "usuários"
    #@users = User.scoped(order: :name)
    @users = User.paginate(page: params[:page], order: :name)
    @new_micropost = Micropost.new
      # fresh_when etag: @users, public: false
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @new_micropost = Micropost.new
    @microposts = @user.microposts.paginate(page: params[:page])
    @users = User.all
    @authors = @user.authors.all
    @tags = @user.tags.all
    @origins = @user.origins.all
    @books = @user.books.all
    @poems = @user.poems.all
    @songs = @user.songs.all
    @films = @user.films.all
    @others = @user.others.all
    @followers = @user.followers.scoped
    @idols = @user.idols.scoped
      # fresh_when etag: [@user, @microposts], public: false
  end

  def feed
    @title = "mural #{@user.name}"
    @user = User.find_by_salt(cookies[:remember_token])
    @new_micropost = Micropost.new        
    @feed_items = @user.feed.paginate(page: params[:page])
    authors_intro = Author.all
    users_intro = User.all
    @intro = authors_intro.concat(users_intro)
    following = @user.following.all
    idols = @user.idols.all 
    @avatars = idols.concat(following)
      fresh_when etag: [@feed_items, @intro, @avatars]
  end

  def tags
    @title = "temas"
    @user = User.find(params[:id])
    @user_tags = @user.tags.all(limit: 20)
    @users = @user.tags.paginate(page: params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    render 'show_tags'
  end

  def origins
    @title = "origens"
    @user = User.find(params[:id])
    @user_origins = @user.origins.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_origins'
  end

  def books
    @user = User.find(params[:id])
    @title = "livros de #{@user.name}"
    @user_books = @user.books.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_books'
  end

  def songs
    @user = User.find(params[:id])
    @title = "músicas de #{@user.name}"
    @user_songs = @user.songs.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_songs'
  end

  def poems
    @user = User.find(params[:id])
    @title = "poemas de #{@user.name}"
    @user_poems = @user.poems.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_poems'
  end

  def films
    @user = User.find(params[:id])
    @title = "filmes de #{@user.name}"
    @user_films = @user.films.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_films'
  end

   def others
    @user = User.find(params[:id])
    @title = "materiais de #{@user.name}"
    @user_others = @user.others.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_others'
  end

  def new
  	@user = User.new
    @title = "cadastre-se"
  end

  def edit
    @user = User.find(params[:id])
    @title = "editar"
    @new_micropost = Micropost.new
  end

  def update
    @new_micropost = Micropost.new
    if @user.update_attributes(params[:user])
      signin @user
      flash[:success] = "Perfil atualizado com sucesso!"
      redirect_to @user
    else
      @title = "editar"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    sign_out
    redirect_to root_path
  end

  def following
    @title = "seguindo"
    @user = User.find(params[:id])
    @following = @user.following.paginate(page: params[:page], order: :name)
    @users_intro = User.all
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    render 'show_following'
  end

  def followers
    @title = "seguidores"
    @user = User.find(params[:id])
    @followers = @user.followers.paginate(page: params[:page], order: :name)
    @new_micropost = Micropost.new
    render 'show_followers'
  end

  def idols
    @title = "ídolos"
    @user = User.find(params[:id])
    @idols = @user.idols.paginate(page: params[:page], order: :name)
    @author_favourites = @user.authors
    @authors_intro = Author.all
    @new_micropost = Micropost.new
    render 'show_idols'
  end

  def authors
    @title = "pensadores"
    @user = User.find(params[:id])
    @users_authors = @user.authors.all(limit: 40)
    @users = @user.authors.paginate(page: params[:page])
    @new_micropost = Micropost.new
    render 'show_authors'
  end

  def favourites
    @title = "favoritas"
    @user = User.find(params[:id])
    @favourites = @user.favourites.all
    @eleitas = @user.eleitas.paginate(page: params[:page])
    @new_micropost = Micropost.new
    render 'show_favourites'
  end

  def favoritadas
    @title = "favoritadas"
    @user = User.find(params[:id])
    @favoritadas = @user.favoritadas.paginate(page: params[:page])
    @new_micropost = Micropost.new
    render 'show_favoritadas'
  end

  def proprias
    @user = User.find(params[:id])
    @proprias = @user.proprias.paginate(page: params[:page])
    @new_micropost = Micropost.new
    @title = "Pensamentos e Frases de #{@user.name}"
    render 'show_proprias'
  end

 private

  def correct_user
    @user = User.find_by_salt(cookies[:remember_token])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end