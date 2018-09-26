Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  resources :movies do
    resources :reviews
  end
  root to: redirect('movies')

  get 'auth/:provider/callback', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  get 'auth/faliure', to: 'sessions#faliure'
  get 'auth/twitter', as: 'login'
end
