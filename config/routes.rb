Rails.application.routes.draw do
  post "/rate", to: "rater#create", as: "rate"
  devise_for :users
  devise_for :users,
    :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


  root "products#index"

  namespace :admin do
    resources :categories
    resources :products
    resources :users
    resources :orders
    resources :suggested_products
  end

  resources :products
  resources :orders, only: [:new, :create, :show]
  resources :suggested_products

  get "/cart", to: "cart#index"
  delete "/cart/:id/delete", to: "cart#destroy"
  post "/cart/:id", to: "cart#create"
  patch "/cart", to: "cart#update"
  get "/cart/:id/edit", to: "cart#edit"

  get "/:page", to: "static_pages#show"
end
