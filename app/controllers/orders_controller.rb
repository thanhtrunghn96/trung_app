# frozen_string_literal: true

class OrdersController < ApplicationController
  # befor_action:set_order, only: [:create, :destroy]
  # befor_action:set_order_item, only: [:destroy]
  before_action :authenticate_user!
  def index
    @cart = Cart.find_by(id: params[:id])
  end

  def show; end

  def new;  end

  def create
    @order = @cart.orders.find_by(product_id: params[:order][:product_id])
    if @order
      @order.update(quantity: @order.quantity.to_i + params[:order][:quantity].to_i)
    else
      @order = @cart.orders.create(order_params)
    end
    redirect_to cart_path @cart
  end

  def destroy
    @cart = Cart.find_by(id: session['cart_id'])
    @order = Order.find_by(id: params[:id])
    @order.destroy
    redirect_to cart_path @cart
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :product_id)
  end
end
