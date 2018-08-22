# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|vi/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    post 'carts/checkout/:id' => 'carts#checkout', as: :cart_checkout
    # post 'orders/update_quantity/:id' => 'order_details#update_quantity', as: :quantity
    get 'orders/detail/:id' => 'orders#index', as: :detail_order
    root to: 'products#index'
    resources :categories
    resources :products
    resources :orders
    resources :carts
  end
  devise_for :users
end
