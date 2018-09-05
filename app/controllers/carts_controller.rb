# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: tim hieu su khac nhau giua bien co @ va khong co @
    # @id = current_user.id
    # @cart = Cart.where(status: 'active', user_id: @id.to_s).order(created_at: :desc)
    # TODO: check tat cac cho viet query tuong tu
    @cart = Cart.where(status: 'active', user: current_user).order(created_at: :desc)
  end

  def checkout
    @cart = Cart.find_by(id: params[:id])
    render 'shared/_404' if @cart.nil?
    @cart.active! # change status
    # TODO: phan biet update va update_attribute
    @cart.update_attribute(:totalprice, @cart.total_price)
    session.delete 'cart_id'
    CartMailer.cart_email(@cart).deliver
    redirect_to localhost_path
  end

  def show
    @cart1 = Cart.find_by(id: params[:id])
    # TODO: viet lai theo cach khac chu khong long nhieu if else vao nhau the nay
    # return render 'shared/_404' if @cart1.nil?
    # return render 'shared/_404' if xxxxx
    return render 'shared/_404' if @cart1.nil?
    @check_user = @cart1.user_id
    if @check_user == current_user.id
      @cart = @cart1
    else
      render 'shared/_404'
    end
  end

  def destroy
    @cart = Cart.find_by(id: session['cart_id'])
    @cart.orders.destroy
    session.delete 'cart_id'
    redirect_to products_path
  end
end
