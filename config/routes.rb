Rails.application.routes.draw do
  resources :lessor_requests
  root 'application#hello'
  get 'static_pages/home'
  resources :properties
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
