Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'about', to: 'static_pages#about'
  get 'queries', to: 'queries#index'
  get :limbo, controller: 'queries'
  post :search, controller: 'queries'
  resources :users do
    resources :recipes, only: %i[index create destroy]
    member do
      get '(/:recipe_name)', to: 'recipes#show', as: 'recipe_name'
    end
  end
  resource :dashboard, only: [:show]
end
