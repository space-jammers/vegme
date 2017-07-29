Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'queries#index'
  post :result_count, controller: 'queries'
  post :search, controller: 'queries'
  resources :users do
    resources :recipes, only: %i[index create destroy]
    member do
      get '(/:recipe_name)', to: 'recipes#show', as: 'recipe_name'
    end
  end
  resource :dashboard, only: [:show]
end
