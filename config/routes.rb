# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  post '/dashboard', to: 'users/viewing_parties#create'

  resources :users, only: %i[new create show]

  resources :discover, only: [:index]

  resources :movie, only: %i[index show], controller: 'users/movie' do
    resources :viewing_parties, only: %i[new create], controller: 'users/viewing_parties'
  end

  resources :movies, only: %i[index]
end
