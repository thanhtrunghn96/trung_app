# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|vi/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    post 'carts/checkout/:id' => 'carts#checkout', as: :cart_checkout
    get 'shop/sold' => 'orders#sold', as: :user_sold
    get 'carts/detail/:id' => 'orders#index', as: :detail_cart
    root to: 'pages#index', as: :localhost
    resources :categories
    resources :products
    resources :orders
    resources :carts
  end
  devise_for :users
end
