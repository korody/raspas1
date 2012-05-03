class NotificationsMailer < ActionMailer::Base

  default :from => "#{message.email}"
  default :to => "korody@raspas.com.br"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end