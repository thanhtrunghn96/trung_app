# frozen_string_literal: true

class AddCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :totalprice, :decimal
    add_column :carts, :status, :integer, default: 1
    add_reference :carts, :user, foreign_key: true
  end
end
