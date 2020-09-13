Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
  end



  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"


  get "/register", to: 'users#new'
  post '/register', to: 'users#create'
  get '/profile', to: 'users#index'

  get '/login', to: 'sessions#new', as: 'login_index'
  post '/login', to: 'sessions#create'
end
