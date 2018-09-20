Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  resources :movies
  root to: redirect('movies')

  get 'auth/:provider/callback', to: 'sessions#create'
  post 'logout' => 'sessions#destroy'
  get 'auth/faliure' => 'sessions#faliure'
  get 'auth/twitter', as: 'login'
end
