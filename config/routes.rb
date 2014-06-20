Rails.application.routes.draw do
  resources :visual_utilizations

  resources :visuals do
    put :associate, on: :member
  end

  resources :bookmarks
  resources :contents do
    put :bookmark, on: :member
  end
  resources :videos, controller: 'visuals', type: 'Video'
  resources :images, controller: 'visuals', type: 'Image'
  resources :bibliotecas, controller: 'contents', type: 'Biblioteca'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  post 'contents/uploadToServer'
  post 'contents/setPlaylist'

  root 'home#index'

end
