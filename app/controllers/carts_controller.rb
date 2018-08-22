# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  def index
    @cart = Cart.where(status: 'active').order(created_at: :desc)
  end

  def checkout
    @cart = Cart.find_by(id: params[:id])
    @cart.active! # change status
    @cart.update_attribute(:totalprice, @cart.total_price)
    session.delete 'cart_id'
    CartMailer.cart_email(@cart).deliver
    redirect_to products_path
  end

  def show
    @cart = Cart.find_by(id: params[:id])
    render 'shared/_404' if @cart.nil?
  end

  def destroy
    @cart = Cart.find_by(id: session['cart_id'])
    @cart.orders.destroy
    session.delete 'cart_id'
    redirect_to products_path
  end
end
