# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :orders, dependent: :destroy # khi card bi huy thi order bi huy theo
  belongs_to :user
  before_destroy :check_if_has_order
  enum status: %i[active notactive]
  # Dynamic Finders
  def add_product(product_id)
    current_item = orders.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = orders.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    orders.to_a.sum(&:total_price) # to_a chuyen doi tuong sang 1 mang
  end

  def check_if_has_order?
    orders.empty?
  end
end
