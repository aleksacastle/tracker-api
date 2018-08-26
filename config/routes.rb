Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'

  resources :users, only: [:create]
  post '/signup', to: 'users#create'

  namespace :api do
    namespace :v1 do
      resources :issues
    end
  end
end
