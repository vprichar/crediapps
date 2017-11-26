Rails.application.routes.draw do
  resources :configuracions

  resources :clients

  resources :payments



  resources :furnitures

  get 'angular/show'
  root 'angular#show'

  resources :sales do
    collection do
      get 'clientsSearch'
      get 'furnitureSearch'
      get 'add_item'
      get 'getFurnitureSale'
      get 'setClient'
      get 'selecDeadlines'
      get 'getDeadlines'
    end
  end


end
