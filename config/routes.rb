Rails.application.routes.draw do
  root 'articles#index'
  get 'about', to: 'pages#about'

  resources :articles do
    member do
      put "like", to: "articles#upvote"
      put "dislike", to: "articles#downvote"
    end
    resources :comments, only: [:create]
  end

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]

  mount ActionCable.server => '/cable'

  get '/chat', to: 'chatrooms#show'
  resources :messages, only: [:create]
end


