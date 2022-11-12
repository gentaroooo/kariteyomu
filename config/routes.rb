Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'posts#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  get '/terms' => 'static_pages#terms'
  get '/privacy' => 'static_pages#privacy'
  post '/guest_login', to: 'user_sessions#guest_login'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  resource :profile, only: %i[show edit update]

  resources :users, only: %i[new create index show] do
    member do
      get :following, :follower, :show_post, :show_book
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
  resources :libraries, only: [:index, :create, :destroy, :edit, :update]


  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
end
