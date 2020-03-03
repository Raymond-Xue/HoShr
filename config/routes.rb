Rails.application.routes.draw do
  resources :groups
  root 'static_pages#home'
  get 'static_pages/home'
  get '/recommendation', to: 'recommend#show'
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
