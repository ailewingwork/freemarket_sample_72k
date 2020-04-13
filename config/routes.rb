Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'users', to: 'users/registrations#new_1st_view'
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'ships', to: 'users/registrations#new_ship'
    post 'ships', to: 'users/registrations#create_ship'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root to: 'items#index'
  resources :users
  # resource :users
  resources :items
end

