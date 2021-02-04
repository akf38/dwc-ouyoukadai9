Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
   
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :following, :followers
    end
  end
  
  resources :books do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  
  get '/search' => 'search#search'
  
  resources :chats, only: [:create]
  
  resources :rooms, only: [:show, :create]
end