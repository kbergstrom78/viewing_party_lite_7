# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  post '/dashboard', to: 'users/viewing_parties#create'

  resources :users do
    resources :discover, only: [:index], controller: 'users/discover'
  end

  resources :movie, only: %i[index show], controller: 'users/movie' do
    resources :viewing_parties, only: %i[new create], controller: 'users/viewing_parties'
    end
  end
end
