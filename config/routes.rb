Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'
  get 'welcome/index'

  get 'signup', to: 'users#new'
  resources :users

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  namespace :api do
    namespace :v1 do
      get '/narigraphs', to: 'narigraphs#index'
      post '/narigraphs', to: 'narigraphs#create'

      get '/klasses', to: 'gameplay#klass_index'
      get '/chat', to: 'gameplay#chat_index'
      post '/chat', to: 'gameplay#chat_create'
    end
  end

  get 'games/index'
  get 'games/:game_id/play', to: 'games#play', as: 'play_game'
  post 'games/join', to: 'games#join', as: 'join_game'
  resources :games do
    resources :characters, shallow: true
    get 'characters/react_new'
  end

  post 'games/:game_id/narigraphs/move_roll', to: 'narigraphs#move_roll', as: 'roll_for_game'

  post 'characters/:id/set_active', to: 'characters#set_active', as: 'set_active'

  post 'characters/:id/join_party', to: 'characters#join_party', as: 'join_party'

  post 'user/:id/deactivate', to: 'users#set_inactive', as: 'user_deactivate'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
