Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/home'
  get '/recommendation', to: 'recommend#show'

  get 'sessions/new'
  
  
  get 'static_pages/home'
  get  '/signup',  to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'

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
