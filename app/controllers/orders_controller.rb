# frozen_string_literal: true

class OrdersController < ApplicationController
  # befor_action:set_order, only: [:create, :destroy]
  # befor_action:set_order_item, only: [:destroy]
  before_action :authenticate_user!
  def index
    @oder = Oder.all
  end

  def show; end

  def new
  end
  # def create
  #   @cart = current_cart
  #   product = Product.find(params[:product_id])
  #   # @order = @cart.add_product(product.id)
  #   @order = @cart.orders.build order_params
  #   @order.product_id = product.id
  #   if @order.save
  #     redirect_to cart_path @cart
  #   else
  #     render :new
  #   end
  # end

  def create
    @order = current_cart.orders.find_by(product_id: params[:order][:product_id])
    render 'shared/_404' if @order.nil?
    if @order
      @order.update(quantity: @order.quantity.to_i + params[:order][:quantity].to_i)
    else
      @order = current_cart.orders.create(order_params)
    end
    redirect_to cart_path current_cart
  end

  def destroy
    @cart = current_cart
    @order = Order.find_by(id: params[:id])
    @order.destroy
    redirect_to cart_path @cart
  end

  private

  # def set_order_item
  #   @order_item = Order.find(params[:id])
  # end

  def order_params
    params.require(:order).permit(:quantity, :product_id)
  end
end
