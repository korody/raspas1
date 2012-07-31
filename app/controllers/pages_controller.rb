# encoding: utf-8
class PagesController < ApplicationController
  
  def home
    @title = "crie, colecione e compartilhe pensamentos"
    @user = User.new
    @feed_items = Micropost.paginate(page: params[:page], order: 'microposts.created_at DESC')
    @authors = Author.scoped(order: 'authors.created_at DESC')
    @users = User.scoped(order: 'users.created_at DESC')
    @tags = Tag.scoped(order: 'tags.created_at DESC')
    @new_micropost = Micropost.new
  end

  def about
    @title = "sobre o raspas"
    @new_micropost = Micropost.new
  end

  def mosaico
    @title = "mosaico"
    @authors = Author.scoped
    @new_micropost = Micropost.new
  end
end