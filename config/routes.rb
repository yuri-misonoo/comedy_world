Rails.application.routes.draw do
  get 'sessions/new'
  root 'homes#top'
  get '/signup' => 'users#new'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  resources :users
  resources :posts
end
