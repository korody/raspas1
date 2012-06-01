class NotificationsMailer < ActionMailer::Base

  default :from => "noreply@youdomain.dev"
  default :to => "admin@raspas.com.br"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.assunto}")
  end

end