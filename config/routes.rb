Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get "todos", to: "todos#index"
  #post "todos/create", to: "todos#create"
  #get "todos/:id", to: "todos#show"
  resources :todos, :users
  post "users/:id/login", to: "users#login"
  get "sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
  root to: "home#index"
  delete "/signout", to: "sessions#destroy", as: :destroy_session
end
