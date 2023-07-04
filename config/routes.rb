# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'
  get '/register', to: 'users#new'

  resources :user_viewing_parties
  resources :viewing_parties
  resources :users
end
