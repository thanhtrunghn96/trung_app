# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_add_attribute, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?
  before_action :session_cart
  before_action :set_locale
  before_action :search_product

  protected

  def session_cart
    return unless current_user
    if session['cart_id']
      @cart = Cart.find_by(id: session['cart_id'])
    else
      last_empty_cart = current_user.carts.includes(:orders).select(&:check_if_has_order?).last
      @cart = last_empty_cart || current_user.carts.create
      session['cart_id'] = @cart.id
    end
  end

  def devise_add_attribute
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone address avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone address avatar])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def search_product
    @q = Product.ransack(params[:q])
  end
end
