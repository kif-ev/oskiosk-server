Rails.application.routes.draw do
  root to: redirect('/ui')
  get 'ui', to: 'frontend#index'
  get 'ui/*path', to: 'frontend#index'
  mount_devise_token_auth_for 'Admin', at: 'admin/auth'
  get 'heartbeat' => 'heartbeat#check'
  concern :taggable do
    resources :tag_autocompletes, only: :index
  end
  resources :identifiers, only: :show
  resources :users, only: %i(show index create update destroy),
            concerns: :taggable do
    resource :user_deposit, only: :create, path: 'deposit'
  end
  resources :products, only: %i(index show create update destroy),
            concerns: :taggable
  resources :carts, only: %i(create show update) do
    resource :cart_payment, only: :create, path: 'pay'
  end
  resources :transactions, only: %i(index show) do
    collection do
      match 'search', via: :post
    end
  end
  resources :admins, only: %i(show index create update destroy)
  resources 'metrics', only: :index
end
