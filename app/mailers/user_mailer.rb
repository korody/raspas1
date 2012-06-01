class UserMailer < ActionMailer::Base
	default :from => "admin@raspas.com.br"
  
	def registration_confirmation(user)
		#@user = user
		#attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
		mail(to: "user.email", subject: "Bem-vindo ao Raspas!")
	end
end