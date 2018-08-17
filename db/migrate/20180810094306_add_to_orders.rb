# frozen_string_literal: true

class AddToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :quantity, :integer, default: 1
  end
end
