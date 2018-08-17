# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  # belongs_to :transaction
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
  def total_price
    product.price * quantity
  end
end
