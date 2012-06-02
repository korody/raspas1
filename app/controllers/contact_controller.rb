class ContactController < ApplicationController
  before_filter :authenticate, :only => :create

  def new
    @message = Message.new
    @new_micropost = Micropost.new
  end

  def create
    @new_micropost = Micropost.new
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      flash[:success] = "Obrigado pelo contato! Responderemos a mensagem em breve."
      redirect_to current_user
    else
      render :new
    end
  end

end