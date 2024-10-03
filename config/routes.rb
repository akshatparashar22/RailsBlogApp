Rails.application.routes.draw do
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    registration: 'users/registrations'
  }
  root "articles#index"

  resources :articles do
    resources :comments
  end

  devise_scope :user do
    delete 'delete_profile', to: 'registrations#destroy', as: :delete_profile
  end
end
