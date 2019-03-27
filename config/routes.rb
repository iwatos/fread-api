Rails.application.routes.draw do
  resources :lists
  resources :users

  get "/get_feed" => "lists#get_feed"
end
