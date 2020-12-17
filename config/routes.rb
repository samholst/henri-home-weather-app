Rails.application.routes.draw do
  root to: 'pages#home'
  get '/search', to: 'pages#search'

  resources :locations, only: [:create, :destroy]
end
