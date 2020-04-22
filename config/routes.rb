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
  resource :users
  resources :items do
    member do
      get 'buy_confirm' # 実装後削除
    end
  end
  resources :credit_cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'credit_cards#pay'
    end
  end
  resources :items do
    resources :buyers, only: [:index] do
      collection do
        get 'done', to: 'buyers#done'
        post 'pay', to: 'buyers#pay'
      end
    end
  end
  get 'get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
  get 'get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
  resources :items, only: [:show, :new, :create, :edit, :update, :destroy] do
    #Ajaxで動かす為のルーティングを作成
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'select_category_index'
      get 'select_child_category_index'
      get 'select_grandchild_category_index'
    end
  end
end

