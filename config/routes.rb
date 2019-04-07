Rails.application.routes.draw do
  resources :tabs
  resources :lists
  resources :users

  get "/get_feed" => "lists#get_feed"
  post "/login" => "users#login"
  post "/loginUser" => "users#loginUser"
end
