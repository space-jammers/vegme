Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'about', to: 'static_pages#about'
  get 'queries', to: 'queries#index'
  get :limbo, controller: 'queries'
  post :search, controller: 'queries'
  resources :users
  resources :recipes, only: %i[show create destroy]
  resource :dashboard, only: [:show]
  resources :feedbacks, only: %i[new create update]
  namespace :admin do
    resources :feedbacks, only: %i[index new create update destroy]
  end
end
