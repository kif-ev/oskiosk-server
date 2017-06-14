Rails.application.routes.draw do
  use_doorkeeper
  get 'heartbeat' => 'heartbeat#check'
  concern :taggable do
    resources :tag_autocompletes, only: :index
  end
  resources :identifiers, only: :show
  resources :users, only: %i(show index create update),
            concerns: :taggable do
    resource :user_deposit, only: :create, path: 'deposit'
  end
  resources :products, only: %i(index show create update),
            concerns: :taggable
  resources :carts, only: %i(create show update) do
    resource :cart_payment, only: :create, path: 'pay'
  end
  resources :transactions, only: %i(index show) do
    collection do
      match 'search', via: :post
    end
  end
end
