Rails.application.routes.draw do
  root :to => 'categories#index'

  match '/signin', :to => 'sessions#new', via: :get, as: :sign_in
  match '/signup', :to => 'users#new', via: :get, as: :sign_up

  resources :users
  resources :sessions, :only => [:create, :destroy, :new]

  resources :categories do
    resources :posts
  end

  # match '500', :to => 'application#server_error'
  # How to route to 400, 402, 500 pages?

end
