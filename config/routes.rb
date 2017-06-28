Rails.application.routes.draw do

  get 'sessions/new'

  get '/signup', to:'users#new'
  post '/signup', to:'users#create'
  get '/static_pages/home'
  get '/help', to: 'static_pages#help'#, as: 'helf'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#   if Rails.env.production?
##      root 'users#index'
#      root 'application#hello'
      root 'static_pages#home'
#   end

end
