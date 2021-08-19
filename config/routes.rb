Rails.application.routes.draw do
  get 'sessions/new'
  get "page_not_fould", to: "page_error#not_fould"
  get "page_error_server", to: "page_error#error_server"
  root "sessions#new"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
end
