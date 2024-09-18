Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'api/v1/sessions' }
  root "articles#index"

  devise_scope :user do
    post 'api/v1/login', to: 'api/v1/sessions#create'
    delete 'api/v1/logout', to: 'api/v1/sessions#destroy'
  end

  resources :articles do
    resources :comments
  end

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :show, :create, :update, :destroy]
      post 'signup', to: 'users#signup'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end
end
