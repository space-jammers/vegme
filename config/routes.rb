Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'queries#index'
  post :search, controller: 'queries'
  resources :users do
    resources :recipes, only: %i[index show destroy]
    member do
      get '(/:name)', to: 'recipes#create', as: 'name'
    end
  end
  resource :dashboard, only: [:show]
end
