Rails.application.routes.draw do



  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :clients
      resources :contacts
      resources :organizations
      post 'clients' => 'clients#create', :as => 'register'
      post 'organization' => 'static_pages#phonenumber', :as => 'fiorg'
      get 'organization' => 'static_pages#phonenumber_results', :as => 'fior2'
      get 'contacts/qwerty/:phone_number' => 'contacts#show'
      get 'contacts/client/:phone_number' => 'contacts#show1'
    end
  end


  resources :contacts, :except => ['show']
  get 'contacts/:phone_number' => 'contacts#show'


resource :contacts
  resources :comments
  resources :users

  resources :clients
  get 'sessions/new'
  get "clients/autocomplete" => "clients#autocomplete"
  get 'users/new'
  get 'search' => 'static_pages#search'
  get 'search_results' => 'static_pages#search_results'
  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :organizations do
    resources :clients do
      resources :contacts
    end
  end

resources :organizations do
  resources :clients do
      resources :comments
     end
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
