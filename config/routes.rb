Rails.application.routes.draw do
  # get 'sessions/new'
  root to: "home#index"
  get 'home/index', to: 'home#index'

  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Custom sign-out route
  delete 'sign_out', to: 'sessions#destroy', as: :destroy_user_session
  
  get 'login', to: 'sessions#new', as: :login


end
