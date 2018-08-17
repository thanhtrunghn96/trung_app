# frozen_string_literal: true

class AddCardToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :cart_id, :integer
  end
end
