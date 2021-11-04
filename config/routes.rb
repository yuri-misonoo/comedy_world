Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'homes#top'
  get '/signup' => 'users#new'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  delete '/signout' => 'sessions#destroy'
  get 'users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
