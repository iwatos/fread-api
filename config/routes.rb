Rails.application.routes.draw do
  resources :lists
  get 'login/login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "users" => "users#index"
  post 'login/login'
end
