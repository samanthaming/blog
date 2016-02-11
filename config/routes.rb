Rails.application.routes.draw do

  root 'home#index'
  get '/about' => 'home#about'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  # resources :comments
end
