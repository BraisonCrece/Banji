Rails.application.routes.draw do
  resources :categories, except: :show
  resources :products

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create] 
  end
  

  root 'products#index'
end
