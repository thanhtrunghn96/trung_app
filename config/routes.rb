# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  # root to : "categories#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users
  resources :categories
  resources :products
  resources :orders
  resources :carts
end
