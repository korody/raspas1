# encoding:   utf-8
class OriginsController < ApplicationController
  before_filter :authenticate, only: [:create, :destroy, :edit]
  before_filter :authorized_user, only: [:edit, :update, :destroy]

  def index
    @title = "pensamentos e frases de livros, músicas, poemas e filmes"
    @origins = eval("#{params[:controller].classify}.scoped(order: :name)")
    # @origins = params[:type].constantize.all
    # @origins = Origin.scoped(order: :name)
    # @origins = origin.paginate(:page => params[:page])
    @new_micropost = Micropost.new
    @tags = Tag.all
  end

  def autocomplete
    @origins = Origin.order(:name).search("%#{params[:term]}%")
    render json: @origins.map(&:name) 
  end

  def show
      @origin = Origin.find(params[:id])
      @microposts = @origin.microposts.paginate(:page => params[:page])
      @users = @origin.users.scoped
      @tags = @origin.tags.scoped
      @origins = Origin.scoped
      @books = Book.scoped
      @songs = Song.scoped
      @poems = Poem.scoped
      @films = Film.scoped
        # fresh_when etag: [@origin, @microposts], public: true
      @new_micropost = Micropost.new
      @title = "#{@origin.name} - #{@origin.author.name if @origin.author}#{@origin.user.name if !@origin.author}"
  end
  
  def new
    @title = "nova origem"
    @origin = Origin.new
    @new_micropost = Micropost.new
  end

  def create
    # @origin = Origin.new(params[:origin])
    origin = current_user.origins.build(params[:origin])
    if origin.save
      if origin.author
        redirect_to origin
        flash[:success] = "Você adicionou um material de #{origin.author.name}! Obrigado."
      else
        redirect_to origin
        flash[:success] = "Adoramos ver material de sua própria autoria! Obrigado."
      end
    else
      redirect_to :back, notice: origin.errors.full_messages 
      # @title = "nova origem"
      # render 'new'
    end
  end
  
  def edit
    @title = "editar origem"
    @origin = Origin.find(params[:id])
    @new_micropost = Micropost.new
  end

  def update
    @new_micropost = Micropost.new
  	@origin = Origin.find(params[:id])
		@origin.attributes = params[:origin]
    if @origin.content_changed?
	  	@origin.update_attributes(user_id: current_user.id)
	  end
    if @origin.info_changed?
      @origin.update_attributes(user_id: current_user.id)
    end
    if @origin.save
      flash[:success] = "Origem atualizada com sucesso."
      redirect_to @origin
    else
      @title = "editar"
      render 'edit'
    end
  end

  def destroy
    Origin.find(params[:id]).destroy
    flash[:success] = "A origem foi removida com sucesso."
    redirect_to root_path
  end

  def users
    @origin = Origin.find(params[:id])
    @users = @origin.users.all(order: 'users.created_at DESC')
    @new_micropost = Micropost.new
    @origins = Origin.all
    @title = "citaram #{@origin.name}"
    render 'show_users'
  end
    
 	private

  def authorized_user
    @origin = Origin.find(params[:id])
  	if @origin.author_id.blank?
    	@origin = current_user.origins.find_by_id(params[:id])
    	redirect_to root_path if @origin.nil?
  	end
  end
end