Rails.application.routes.draw do
  devise_for :users

  root "products#index"

  namespace :admin do
    resources :categories
    resources :products
  end

  resources :products
  resources :orders, only: [:new, :create, :show]
  get "/cart", to: "cart#index"
  delete "/cart/:id/delete", to: "cart#destroy"
  post "/cart/:id", to: "cart#create"
  patch "/cart", to: "cart#update"
  get "/cart/:id/edit", to: "cart#edit"

  get "/:page", to: "static_pages#show"
end
