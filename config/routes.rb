  Benfeitor::Application.routes.draw do
  ActiveAdmin.routes(self)
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  # require File.expand_path("../../lib/logged_in_constraint", __FILE__)
  # root :to => "users#feed", :constraints => LoggedInConstraint.new(true)
  # root :to => "pages#home", :constraints => LoggedInConstraint.new(false)
  
  scope :constraints => lambda{|request| request.cookies.key?("remember_token") } do
    root :to => "users#feed"
  end    
  root :to => "pages#home"
  
  # get 'authors/page/:page', to: 'authors#index'
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
  # resources :books, path: "livros", controller: "origins", type: "books"
  # resources :poems, path: "poemas", controller: "origins", type: "poems"
  # resources :songs, path: "musicas", controller: "origins", type: "songs"
  # resources :films, path: "filmes", controller: "origins", type: "films"
  
  resources :sessions, only: [:new, :create, :authenticate, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :destroy]
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/home',   to: 'pages#home'
  match '/about',   to: 'pages#about'
  match 'contact' => 'contact#new', as: 'contact', via: :get
  match 'contact' => 'contact#create', as: 'contact', via: :post
  match '/auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match '/search', to: "search#index"
  match '/mosaico', to: "pages#mosaico"
  match '/top', to: "pages#top"
  match '/random', to: "microposts#random"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end