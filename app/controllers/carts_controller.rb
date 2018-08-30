# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  def index
    @id = current_user.id
    @cart = Cart.where(status: 'active', user_id: @id.to_s).order(created_at: :desc)
  end

  def checkout
    @cart = Cart.find_by(id: params[:id])
    @cart.active! # change status
    @cart.update_attribute(:totalprice, @cart.total_price)
    session.delete 'cart_id'
    CartMailer.cart_email(@cart).deliver
    redirect_to localhost_path
  end

  def show
    @cart1 = Cart.find_by(id: params[:id])
    if @cart1.nil?
      render 'shared/_404'
    else
      @check_user = @cart1.user_id
      if @check_user == current_user.id
        @cart = @cart1
      else
        render 'shared/_404'
      end
    end
  end

  def destroy
    @cart = Cart.find_by(id: session['cart_id'])
    @cart.orders.destroy
    session.delete 'cart_id'
    redirect_to products_path
  end
end
