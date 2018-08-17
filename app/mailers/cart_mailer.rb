# frozen_string_literal: true

class CartMailer < ApplicationMailer
  default from: 'trung_app@example.com'

  def cart_email(cart)
    @cart = cart
    mail(to: @cart.user.email, subject: 'Confirm Your Check out')
  end
end
