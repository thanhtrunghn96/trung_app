# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_add_attribute, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?
  # befor_action :set_order

  private

  def current_cart
    Cart.find_by(id: session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  protected

  def devise_add_attribute
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone address])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone address])
  end
end
