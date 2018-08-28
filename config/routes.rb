Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: [:create]
  post '/signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'

  namespace :api do
    namespace :v1 do
      resources :issues
    end
  end
end
