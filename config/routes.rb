Rails.application.routes.draw do

  root 'home#index'
  get '/about' => 'home#about'

  # CRUD (Posts)

  ## Create
  get '/posts/new' => 'posts#new', as: :new_posts
  post '/posts' => 'posts#create', as: :posts

  ## Read
  get '/posts' => 'posts#index'
  get '/posts/:id' => 'posts#show', as: :post

  ## Update
  get '/posts/:id/edit' => 'posts#edit', as: :edit_post
  patch '/posts/:id' => 'posts#update'

  ## Destroy
  delete '/posts/:id' => 'posts#Destroy'


  # CRUD (Comments)
  resources :comments
end
