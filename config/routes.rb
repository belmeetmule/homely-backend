Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace :api do
    namespace :v1 do
      resources :users, only: [:indx] do
        resources :reservations, only: [:index, :create, :destroy]
      end
      resources :houses, only: [:index, :show, :create, :destroy]
    end
  end

  # root "articles#index"

    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

end
