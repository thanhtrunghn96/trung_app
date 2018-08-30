# frozen_string_literal: true

class OrdersController < ApplicationController
  # befor_action:set_order, only: [:create, :destroy]
  # befor_action:set_order_item, only: [:destroy]
  before_action :authenticate_user!
  def index
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

  def show; end

  def new;  end

  def sold; end

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
    params.require(:order).permit(:quantity, :product_id, :product_name, :product_price)
  end
end
