Rails.application.routes.draw do
  use_doorkeeper
  get 'heartbeat' => 'heartbeat#check'
  resources :identifiers, only: [:show]
  resources :users, only: [:show, :index] do
    resource :user_deposit, only: [:create], path: 'deposit'
  end
  resources :products, only: [:index, :show, :create]
  resources :carts, only: [:create, :show, :update] do
    resource :cart_payment, only: [:create], path: 'pay'
  end
  resources :transactions, only: [:index, :show] do
    collection do
      match 'search', via: [:post]
    end
  end
end
