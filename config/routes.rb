Rails.application.routes.draw do

  root 'home#index'
  get '/about' => 'home#about'

  resources :posts do
    resources :comments, only: [:create, :destroy, :index]
    resources :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :show, :update, :edit]
  get "/password" => "users#edit_password", as: :edit_password
  patch "/password" => "users#update_password", as: :update_password
  resources :favorites, only: [:index]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
