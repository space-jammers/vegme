Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'queries#index'
  post :search, controller: 'queries'
  resources :recipes do
    member do
      get '(/:name)', to: 'recipes#show', as: 'name'
    end
  end
end
