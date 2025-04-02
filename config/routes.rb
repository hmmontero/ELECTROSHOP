Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  resources :products do
    resources :cart_products, only: [:create, :destroy]
  end

  resources :carts, only: [:show, :update, :destroy] do
    resources :payments, only: [:show, :create]
  end

  patch "/cart_products/:id/increment", to: "cart_products#increment", as: :increment
  patch "/cart_products/:id/decrement", to: "cart_products#decrement", as: :decrement

end
