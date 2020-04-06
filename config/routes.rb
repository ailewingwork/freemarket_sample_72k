Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'users', to: 'users/registrations#new_1st_view'
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  root to: 'items#index'
  resources :users
  resources :item, except: [:index]

end