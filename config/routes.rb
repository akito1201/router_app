Rails.application.routes.draw do
  get 'users/:user_id/show', to: 'users#show'
  get 'users/:user_id/index', to: 'users#index'
  get 'posts/:post_id/favorites', to: 'favorites#check'
  get 'users/:user_id/favorites', to: 'favorites#index'
  get 'posts/:post_id/favorite_counts/:count', to: 'favorite_counts#count'

  root to: 'posts#index'
  devise_for :users

  resources :posts  do
    resources :plans, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :favorite_counts, only: :index

end
