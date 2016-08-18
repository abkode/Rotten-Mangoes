Rails.application.routes.draw do
  get 'reviews/new'

  get 'reviews/create'

  get 'sessions/new'

  get 'sessions/create'

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # get 'users/new'
 # get 'users/create'

 # get 'users/index'

	resources :movies do
    	resources :reviews, only: [:new, :create]
  end

	resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'

  namespace :admin do
    resources :users
  end

end
