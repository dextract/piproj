Rails.application.routes.draw do
  resources :videos

  resources :bookmarks
  resources :contents
  resources :users
  root 'home#index'
end
