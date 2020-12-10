Rails.application.routes.draw do
  root to: 'users#new'
  get '/users', to: redirect('/')
  resources :users, only: :create
end
