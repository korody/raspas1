# encoding:   utf-8
class AuthorsController < ApplicationController
  before_filter :authenticate, only: [:edit, :update, :new]

  def index
    @title = "pensadores"
    @authors = Author.scoped(order: :name)
    # @authors = Author.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @tags = Tag.all
        # fresh_when etag: @authors, public: true
  end

  def autocomplete
    @authors = Author.order(:name).search("%#{params[:term]}%")
    render json: @authors.map(&:name) 
  end

  def show
      @author = Author.find(params[:id])
      @microposts = @author.microposts.paginate(:page => params[:page])
      @users = @author.users.scoped
      @tags = @author.tags.scoped
      @authors = Author.scoped
      @origins = @author.origins.all
      @books = @author.books.scoped
      @poems = @author.poems.scoped
      @songs = @author.songs.scoped
      @films = @author.films.scoped
      @others = @author.others.scoped
        # fresh_when etag: [@author, @microposts], public: true
      @new_micropost = Micropost.new
      @title = "Pensamentos e Frases de #{@author.name}"
  end
  
  def new
    @title = "novo pensador"
    @author = Author.new
    @new_micropost = Micropost.new
  end

  def create
    @new_micropost = Micropost.new
    # @author = Author.new(params[:author])
    @author = current_user.authors.build(params[:author])
    if @author.save
      flash[:success] = "Perfil para #{@author.name} criado com sucesso!"
      redirect_to @author
    else
      @title = "novo pensador"
      render 'new'
    end
  end

  def edit
    @title = "editar pensador"
    @author = Author.find(params[:id])
    @new_micropost = Micropost.new
  end

  def update
    @new_micropost = Micropost.new
    @author = Author.find(params[:id])
    @author.attributes = params[:author]
    if @author.bio_changed?
      @author.update_attributes(user_id: current_user.id)
    end
    if @author.image_changed?
      expire_fragment("mosaico")
      expire_fragment("mosaico_page")
    end
    if @author.save
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
    @author = Author.find(params[:id])
    @author_tags = @author.tags.all(:order => 'tags.created_at DESC', :limit => 20)
    @tags = @author.tags.paginate(:page => params[:page])
    @authors = Author.all
    @new_micropost = Micropost.new
    @title = "temas escritos por #{@author.name}"
    render 'show_tags'
  end

  def fans
    @author = Author.find(params[:id])
    @fans = @author.fans.paginate(:page => params[:page], order: "name")
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @title = "fãs de #{@author.name}"
    render 'show_fans'
  end

  def users
    @author = Author.find(params[:id])
    @users = @author.users.all(:order => 'users.created_at DESC')
    @new_micropost = Micropost.new
    @authors = Author.all
    @title = "citaram #{@author.name}"
    render 'show_users'
  end
       
  def favourites
    @author = Author.find(params[:id])
    @favourites = @author.favourites.all
    @eleitas = @author.eleitas.paginate(page: params[:page], select: "micropost_id, count(id) as eleitas_count", group: "micropost_id", order: "eleitas_count DESC" )
    @authors = Author.all
    @new_micropost = Micropost.new
    @title = "favoritas de #{@author.name}"
    render 'show_favourites'
  end

  def origins
    @author = Author.find(params[:id])
    @title = "materiais de #{@author.name}"
    @author_origins = @author.origins.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_origins'
  end

  def books
    @author = Author.find(params[:id])
    @title = "livros de #{@author.name}"
    @author_books = @author.books.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_books'
  end

  def songs
    @author = Author.find(params[:id])
    @title = "músicas de #{@author.name}"
    @author_songs = @author.songs.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_songs'
  end

  def poems
    @author = Author.find(params[:id])
    @title = "poemas de #{@author.name}"
    @author_poems = @author.poems.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_poems'
  end

  def films
    @author = Author.find(params[:id])
    @title = "filmes de #{@author.name}"
    @author_films = @author.films.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_films'
  end

   def others
    @author = Author.find(params[:id])
    @title = "materiais de #{@author.name}"
    @author_others = @author.others.all
    # @origins = @origin.tags.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @authors = Author.all
    @tags = Tag.all
    @origins = Origin.all
    render 'show_others'
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