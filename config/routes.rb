Benfeitor::Application.routes.draw do
  # scope :constraints => lambda{|request| request.cookies.key?("remember_token") } do
  #   root :to => "users#feed"
  # end    

  root :to => "pages#home"

  resources :authors, :path => "pensadores" do
    member do
      get :fans, path: "fas"
      get :idols, path: "idolos"
      get :users, path: "usuarios"
      get :tags, path: "temas"
      get :favourites, path: "favoritas"
      get :origins, path: "origens"
      get :books, path: "livros"
      get :songs, path: "musicas"
      get :poems, path: "poemas"
      get :films, path: "filmes"
      get :others, path: "outras"
      get :subscriptions, :autocomplete
    end
  end

  resources :users, path: "usuarios" do
    member do
      get :feed, path: "mural"
      get :following, path: "seguindo"
      get :followers, path: "seguidores"
      get :idols, path: "idolos"
      get :fans, path: "fas"
      get :tags, path: "temas"
      get :authors, path: "pensadores"
      get :favourites, path: "favoritas"
      get :origins, path: "origens"
      get :books, path: "livros"
      get :songs, path: "musicas"
      get :poems, path: "poemas"
      get :films, path: "filmes"
      get :others, path: "outras"
      get :favoritadas
      get :proprias
      get :twitter
    end
  end

  resources :tags, path: "temas" do
    member do
      get :microposts, path: "raspas"
      get :users, path: "usuarios"
      get :authors, path: "pensadores"
      get :autocomplete
    end
  end

  resources :taggins do
    member do
      get :tags, path: "temas"
      get :microposts, path: "raspas"
      get :users, path: "usuarios"
    end
  end

  resources :microposts, path: "raspas" do
    member do
      get :favouriters, path: "favoritaram"
    end
  end

  resources :favourites, path: "favoritas" do
    member do
      get :criar
    end
  end

  resources :origins, path: "origens" do

    member do
      get :fans, path: "fas"
      get :idols, path: "idolos"
      get :users, path: "usuarios"
      get :authors, path: "pensadores"
      get :tags, path: "temas"
      get :autocomplete
    end
  end

  resources :books, path: "livros"
  resources :poems, path: "poemas"
  resources :songs, path: "musicas"
  resources :films, path: "filmes"
  resources :others, path: "outras"
  
  resources :sessions, only: [:new, :create, :authenticate, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :destroy]
  
  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/home',   to: 'pages#home'
  get '/about',   to: 'pages#about'
  get 'contact' => 'contact#new'
  post 'contact' => 'contact#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/search', to: "search#index"
  get '/mosaico', to: "pages#mosaico"
  get '/top', to: "pages#top"
  get '/random', to: "microposts#random"
end