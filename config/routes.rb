Rails.application.routes.draw do

  # root to: 'site#index'
  mount Ckeditor::Engine => '/ckeditor'

  #frontend
  get '/' => 'site#index', as: :home
  get 'product/:id' => 'site#show', as: :show
  get 'cate/:id' => 'site#show_cate', as: :show_cate
  #facebook authenticate
    get 'auth/:provider/callback', to: 'sessions#create_face'
    get 'auth/failure', to: redirect('/')
    get '/signout', to: 'sessions#destroy_fontend', as: 'signout'

    resources :sessions, only: [:create, :destroy]
    resource :home, only: [:show]

    root to: "site#index"



  #backend
  scope "/admin" do
      get '/' => 'sessions#new'
      resources :categories do
        # get :test1, :on => :collection
      end
      resources :products
      # resources :users
      resources :admins
      resources :images

      controller :sessions do
        get 'login' => :new, as: :login
        post 'login' => :create
        get 'logout' => :destroy, as: :logout
      end
      get '/signup' => 'users#new', as: :get_signup
      post '/users' => 'users#create', as: :post_signup
      get '/users/:id/edit' => 'users#edit', as: :edit_user
      get '/users' => 'users#index', as: :users
      get '/users/:id' => 'users#show', as: :user
      patch '/users/:id' => 'users#update'


  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end