Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  resources :charges, only: [:new, :create]
  get 'downgrade' => 'charges#downgrade'
  get 'welcome_about' => 'welcome#about'
  root 'welcome#home'
  resources :collaborators, only: [:new, :create, :destroy]
end
