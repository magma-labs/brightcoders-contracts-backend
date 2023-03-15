# config/routes.rb
Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  delete 'sign_out', to: 'sessions#destroy', as: :destroy_user_session

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  resources :nfts, only: [:new, :create]
end