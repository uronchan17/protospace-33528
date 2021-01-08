Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes, only: [ :new, :create, :destroy, :edit, :update, :show] do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
