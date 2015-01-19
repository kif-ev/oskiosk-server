Rails.application.routes.draw do
  use_doorkeeper
  resources :identifiers, only: [:show]
  resources :users, only: [:show]
  resources :products, only: [:index, :show]
  resources :carts, only: [:create, :show, :update]
  resources :transactions, only: [:create]
end
