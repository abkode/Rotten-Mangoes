Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 	get 'users/new'
	get 'users/create'

	resources :movies
	resources :users, only: [:new, :create]
	resources :sessions, only: [:new, :create]
  
end
