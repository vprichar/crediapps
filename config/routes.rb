Rails.application.routes.draw do
  resources :payments

  resources :sales

  resources :furnitures

  get 'angular/show'
  root 'angular#show'

end
