Rails.application.routes.draw do
  root 'homes#top'
  get '/signin' => 'homes#signin'
  get '/signup' => 'users#new'
  resources :users
  resources :posts
end
