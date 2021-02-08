Rails.application.routes.draw do
  root to: 'stores#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'favorite', on: :member
    resources :profiles, only: [:edit, :update]
  end
    
  resources :stores  do
    get 'search_map', on: :collection
    resources :comments, only: :create
    resource :likes, only: [:create, :destroy]
  end

  resources :communities, only: [:index, :create, :edit, :update, :destroy] do
    get 'search', on: :collection
    resources :messages, only: [:index, :create]  
    resource :favorites, only: [:create, :destroy]
  end
end
