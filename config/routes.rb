Rails.application.routes.draw do
  resources :tabs
  resources :lists
  resources :users

  post "user/get_feed" => "users#get_feed"
  get "/get_feed" => "lists#get_feed"
  post "/login" => "users#login"
  post "/signup" => "users#signup"
  post "/loginUser" => "users#loginUser"
end
