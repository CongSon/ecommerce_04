Rails.application.routes.draw do
  devise_for :users

  root "static_pages#home"

  namespace :admin do
    resources :categories
  end

  resources :products
  get "/cart", to: "cart#index"
  delete "/cart/:id/delete", to: "cart#destroy"
  post "/cart/:id", to: "cart#create"
  patch "/cart/:id", to: "cart#update"
  get "/cart/:id/edit", to: "cart#edit"

  get "/:page", to: "static_pages#show"
end
