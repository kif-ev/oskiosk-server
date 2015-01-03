Rails.application.routes.draw do
  resources :identifiers, only: [:show]
  resources :users, only: [:show]
  resources :products, only: [:show]
  resources :carts, only: [:create, :show, :update]
  resources :transactions, only: [:create]
end
