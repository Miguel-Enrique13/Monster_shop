Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :merchants

  resources :items, only: [:index, :show, :edit, :update, :destroy]

  resources :merchants, only: :show do
    resources :items, only: [:index, :new, :create]
  end

  resources :items, only: :show do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  resources :orders, only: [:new, :create, :show]

  namespace :merchant do
    resources :dashboard, only: :index
  end

  namespace :admin do
    resources :dashboard, only: :index
    get '/users', to: 'dashboard#show_users'
  end

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  post "/cart/:item_id/add", to: "cart#add"
  post "/cart/:item_id/subtract", to: 'cart#subtract'
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"


  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/profile', to: 'users#index'
  get '/profile/edit', to: 'users#edit'
  patch '/profile/edit', to: 'users#update'
  get '/profile/edit_password', to: 'users#edit_password'
  patch '/profile/edit_password', to: 'users#update_password'

  get '/login', to: 'sessions#new', as: 'login_index'
  post '/login', to: 'sessions#create'
  get '/log_out', to: 'sessions#logout'


end
