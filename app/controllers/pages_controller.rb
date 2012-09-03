# encoding: utf-8
class PagesController < ApplicationController
  
  def home
    @title = "Crie, colecione e compartilhe pensamentos."
    @user = User.new
    @feed_items = Micropost.paginate(page: params[:page], order: 'microposts.created_at DESC')
    @authors = Author.scoped(order: 'authors.created_at DESC')
    @users = User.scoped(order: 'users.created_at DESC')
    @tags = Tag.scoped(order: 'tags.created_at DESC')
    @origins = Origin.scoped(order: 'origins.created_at DESC')
    @books = Book.scoped(order: 'origins.created_at DESC')
    @poems = Poem.scoped(order: 'origins.created_at DESC')
    @songs = Song.scoped(order: 'origins.created_at DESC')
    @films = Film.scoped(order: 'origins.created_at DESC')
    @new_micropost = Micropost.new
  end

  def about
    @title = "sobre o raspas"
    @new_micropost = Micropost.new
  end

  def mosaico
    @title = "mosaico de pensadores"
    @authors = Author.scoped
    @new_micropost = Micropost.new
  end

  def top
    @title = "Melhores Frases e Pensamentos"
    @favourites = Favourite.all(select: "micropost_id, count(id) as favourite_count", group: "micropost_id", order: "favourite_count DESC", limit: 30)
    @authors = Author.scoped
    @users = User.scoped
    @new_micropost = Micropost.new
  end
end