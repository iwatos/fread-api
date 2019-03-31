Rails.application.routes.draw do
  resources :tabs
  resources :lists
  resources :users

  get "/get_feed" => "lists#get_feed"
end
