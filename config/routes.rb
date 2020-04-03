Rails.application.routes.draw do
  root 'static_pages#home'
  get 'sessions/new'
  
  # routes to home pages
  get 'static_pages/home'
  get '/search', to: 'static_pages#property_search'
  
  # post '/search', to: 'static_pages#create'
  get '/search_result', to: 'static_pages#result'
  get 'static_pages/show'

  get '/lessee_search', to: 'static_pages#lessee_search'
  get '/lessee_result', to: 'static_pages#lessee_result'
  
  get 'static_pages/show_lessee'

  get  '/signup',  to: 'users#new'
  get '/login', to: 'sessions#new'
  get  'static_pages/signup',  to: 'users#new'
  get 'static_pages/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get '/recommendation', to: 'recommend#show'

  post '/invitation/accept/:invitation_id', to:'invitation#accept', as: 'accept_invitation'
  post '/invitation/send/:group_to_id', to:'invitation#create', as: 'send_invitation'

  get '/my_lessee', to: 'groups#my_lessee'
  post '/submit/:lessee_id', to: 'groups#submit'
  post '/cancel/:property_id', to: 'groups#cancel'

  get '/my_group', to: 'groups#my_group'
  
  get '/uploaded_properties', to: 'users#uploaded_properties'
  get '/show_property/:property_id', to: 'properties#show'
  #post '/edit_property/:property_id', to: 'properties#edit'
  #post '/delete_property/:property_id', to: 'properties#destroy'

  get '/post_property/:property_id', to: 'properties#post'
  
  
  resources :groups
  resources :cities
  resources :states
  resources :countries
  resources :currencies
  resources :types
  resources :rooms
  resources :lessee_requests
  resources :lessor_requests 
  resources :properties
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
