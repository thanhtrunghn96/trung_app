# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  # belongs_to :transaction
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
  def total_price
    product.price * quantity
  end

  def self.to_csv
    attributes = %w{product_name product_price quantity}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |order|
        csv << attributes.map{ |attr| order.send(attr) }
      end
    end
  end

  def product_name
    product.name
  end

  def product_price
    product.price
  end
  
end
