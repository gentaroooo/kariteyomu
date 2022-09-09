Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resource :profile, only: %i[show edit update]
  
  resources :users, only: %i[new create]
  resources :books do
    resources :comments, only: %i[create update destroy], shallow: true
  end
end