Rails.application.routes.draw do
  get 'users/:user_id/show', to: 'users#show'
  get 'users/:user_id/index', to: 'users#index'
  root to: 'posts#index'
  devise_for :users

  resources :posts  do
    resources :plans
  end
  
end
