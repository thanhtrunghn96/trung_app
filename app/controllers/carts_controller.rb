# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  def index
    # @carts = []
    # if session[:cart_id] != nil
    #   @carts << Cart.find_by_id(session[:cart_id])
    # end
  end

  def check_out
    # @cart = Cart.find_by params[id]
    #   @cart.active! #change status
    #   session.delete 'cart_id'

    #   CartMailer.cart_email(@cart).deliver
    #   redirect_to
  end

  def show
    @cart = Cart.find_by(id: params[:id])
    render 'shared/_404' if @cart.nil?
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to products_path
  end
end
