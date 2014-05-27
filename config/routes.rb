Rails.application.routes.draw do
  resources :bookmarks
  resources :contents
  resources :videos, controller: 'contents', type: 'Video'
  resources :users
  root 'home#index'

  post 'home/upload'

end
