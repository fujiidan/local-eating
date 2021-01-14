Rails.application.routes.draw do
  root to: 'stores#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
