Rails.application.routes.draw do
  use_doorkeeper
  resources :identifiers, only: [:show]
  resources :users, only: [:show] do
    resource :user_deposit, only: [:create], path: 'deposit'
  end
  resources :products, only: [:index, :show]
  resources :carts, only: [:create, :show, :update]
  resources :transactions, only: [:create, :index] do
    collection do
      match 'search', via: [:post]
    end
  end
end
