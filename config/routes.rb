# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/dashboard', to: 'users#show'

  resources :user_viewing_parties
  resources :viewing_parties
  resources :users do
    resources :discover, only: [:index], controller: 'users/discover'
  end
end
