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
  resources :viewing_parties, only: %i[new create]
  resources :discover, only: [:index]
  resources :movies, only: %i[index show]
end

