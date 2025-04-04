Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  get 'uploads/new', to: 'uploads#new'
  get 'uploads/sign', to: 'uploads#sign'

  resources :products do
    resources :cart_products, only: [:create, :destroy]
  end

  resources :carts, only: [:show, :update, :destroy] do
    resources :payments, only: [:show, :create]
  end

  patch "/cart_products/:id/increment", to: "cart_products#increment", as: :increment
  patch "/cart_products/:id/decrement", to: "cart_products#decrement", as: :decrement
end
