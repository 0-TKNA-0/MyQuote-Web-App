Rails.application.routes.draw do
  get 'search', to: 'search#index', as: 'search' #This add a route for search
  resources :quote_categories
  resources :categories
  resources :quotes
  resources :philosophers
  resources :users

  patch 'users/:id/update_status', to: 'users#update_status', as: 'update_user_status' # This allows the admin to update a user's status
  delete 'users/:id/delete', to: 'users#delete', as: 'delete_user' # This allows the admin to delete a user
  patch 'users/:id/change_admin', to: 'users#change_admin', as: 'change_admin_user' # This allows the admin to update a user's role

  #get 'home/index'
  get 'home/about'
  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/admin', to: 'home#aindex' # This sends admins to the admin landing page when they login
  get '/userhome', to: 'home#uindex' # This sends standard users to the user landing page when they login
  get '/your-quotes', to: 'home#uquotes' # This sends users to their own quotes page when they want to view their uploaded quotes

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
