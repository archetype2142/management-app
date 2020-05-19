Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      get '/states/:country_name', to: 'v1/states#show', as: :states_fetch
    end
  end
  
  root 'home/homepage#index'  
  namespace :admin do
    resources :products, only: [:index, :show, :new, :create]
    resources :orders, only: [:index, :show, :destroy]

    namespace :customers do
      resources :clients, only: [:index, :create, :show]
      resources :companies, only: [:index, :create]
    end
  end
end
