Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'relationships/create'
  get 'relationships/destroy'

  resource :profile, only: %i[show edit update]
  
  resources :users, only: %i[new create index show] do
    member do
      get :following, :follower
    end
  end 
  
  resources :books do
    collection { get :search }
  end
 
  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
    resources :likes, only: %i[create destroy]
      collection do
        get :likes
      end
  end
  resources :likes, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]

  resources :relationships, only: [:create, :destroy]

  resources :libraries, only: [:index, :create, :destroy]
end