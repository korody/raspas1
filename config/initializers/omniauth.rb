#OmniAuth.config.full_host = "http://localhost:3000"
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'sGqABtLbkWDt0gItOqwFyw', '4TrM2Zs7ZDRSUomeMCL0zQwRzS2zKAYnibn1JAk'
  provider :facebook, '282523151767333', 'cd8002901bdd85dedbb15944d91b803b', {:client_options => {:ssl => {:ca_path => "C:/Ruby/Git/ssl/certs"}}}
end