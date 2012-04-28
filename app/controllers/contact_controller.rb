class ContactController < ApplicationController

  def new
    @message = Message.new
    @micropost = Micropost.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      flash[:success] = "Mensagem enviada! Entraremos em contato em breve."
      redirect_to current_user
    else
      render :new
    end
  end

end