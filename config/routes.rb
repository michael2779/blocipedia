Rails.application.routes.draw do
  devise_for :users

  resources :wikis

  # get 'wikis/index'
  #
  # get 'wikis/show'
  #
  # get 'wikis/new'
  #
  # get 'wikis/edit'



  root 'welcome#home'

end
