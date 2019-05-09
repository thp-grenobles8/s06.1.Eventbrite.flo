Rails.application.routes.draw do


  devise_for :users
  resources :events do
    resources :participations, only: [:create, :index]
  end
  resources :users, only: [:show, :edit, :update]
  root to: 'events#index'
  resources :charges

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
