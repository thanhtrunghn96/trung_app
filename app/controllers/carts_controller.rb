# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_cart, only: [:show, :checkout, :destroy]
  def index
    # TODO: tim hieu su khac nhau giua bien co @ va khong co @
    # @id = current_user.id
    # @cart = Cart.where(status: 'active', user_id: @id.to_s).order(created_at: :desc)
    @cart = Cart.where(status: 'active', user: current_user).order(created_at: :desc)
  end

  def checkout
    @cart.active! # change status
    @cart.update_attribute(:totalprice, @cart.total_price)
    session.delete 'cart_id'
    CartMailer.cart_email(@cart).deliver
    redirect_to localhost_path
  end

  def show; end

  def destroy
    @cart.orders.destroy
    session.delete 'cart_id'
    redirect_to products_path
  end

  private

  def find_by_cart
    @cart = current_user.carts.find_by(id: session['cart_id'])
    render 'shared/_404' if @cart.nil?
  end
end
