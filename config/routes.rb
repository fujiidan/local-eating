Rails.application.routes.draw do
  root to: 'stores#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :profiles, only: [:edit, :update]
  end
    
  resources :stores  do
    collection do 
      get 'search_map'
    end
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end

  resources :communities, only: [:index, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
    resources :messages, only: [:index, :create]
  end
end
