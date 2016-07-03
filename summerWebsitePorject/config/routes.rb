Rails.application.routes.draw do
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
  get '/questions' => 'question#index', :as => :question_index
  get '/questions/new' => 'question#new'
  post '/questions' => 'question#create'
  get '/questions/:id' => 'question#show', :as => :question
  get '/questions/:id/edit' => 'question#edit', as: :edit_question
  patch '/questions/:id' => 'question#update'
  get '/questionsets' => 'qset#index', :as => :qset_index
  get '/questionsets/new' => 'qset#new', :as => :qset_new
  post '/questionsets' => 'qset#create', :as => :qset_create
  get '/questionsets/:id' => 'qset#show', :as => :qset
  get '/questionsets/:id/edit' => 'qset#edit', :as =>:qset_edit
  patch '/questionsets/:id' => 'qset#update'
  get '/signup/:role' => 'user#new', :as => :user_new
  post '/signup/:role' => 'user#create', :as => :user_create
  get '/user/:id' => 'user#show', :as => :user_show
  root 'question#index'
  get '/login' => 'session#new', as: :login
  post '/login' => 'session#create'
  delete '/logout' => 'session#destroy', as: :logout
  get '/taketest/:qset_id' => 'set_result#new', as: :take_test
  post '/taketest/:qset_id' => 'set_result#calculate_results', as: :qset_results_create
end
