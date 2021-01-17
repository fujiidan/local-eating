Rails.application.routes.draw do
  root to: 'stores#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  resources :stores, only: [:index, :new, :create] do
    collection do
      get 'search_map'
    end
  end    
end
