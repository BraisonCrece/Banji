Rails.application.routes.draw do
  get 'favorites/create'
  get '/profile', to: 'profiles#show'
  get '/profile/edit', to: 'profiles#edit'
  patch '/profile', to: 'profiles#update'

  namespace :authentication, path: "", as: "" do
    resources :users, only: [:new, :create], path: "/register", path_names: { new: "" }
    resources :sessions, only: [:new, :create, :destroy], path: "/login", path_names: { new: "" }
  end

  resources :favorites, only: [:index, :create, :destroy], param: :product_id
  resources :users, only: :show, path: "/user", param: :username
  resources :categories, except: :show
  resources :products, path: "/"
  

  root "products#index"
end
