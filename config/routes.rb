Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#health'
  post '/login', to: 'auth#login'
  post '/register', to: 'auth#register'
  resources :expenses, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:index, :show, :create, :update]
end
