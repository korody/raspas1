Benfeitor::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :authors, :path => "pensadores" do
    member do
      get :fans, path: "fas"
      get :idols, path: "idolos"
      get :users, path: "usuarios"
      get :tags, path: "temas"
      get :favourites, path: "favoritas"
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
      get :favoritadas
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
      get :favourites, path: "favoritas"
      get :favouriters, path: "favoritaram"
    end
  end
  
  resources :sessions, :only => [:new, :create, :authenticate, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :subscriptions, :only => [:create, :destroy]
  resources :favourites, :only => [:create, :destroy]
  
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/about',   :to => 'pages#about'
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/search', to: "search#index"

  root :to => 'pages#home'

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