ActionMailer::Base.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => "raspas.com.br",
      :user_name            => "admin@raspas.com.br",
      :password             => "nddssssef",
      :authentication       => :plain,
      :enable_starttls_auto => true
    }