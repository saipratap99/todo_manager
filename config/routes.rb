Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "todos", to: "todos#index"
  post "todos/create", to: "todos#create"
  get "todos/:id", to: "todos#show"
end
