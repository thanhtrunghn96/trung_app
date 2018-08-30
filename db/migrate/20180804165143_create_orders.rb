# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :product, foreign_key: true
      t.references :transaction, foreign_key: true
      t.integer :total_product
      t.decimal :amount
      t.text :data
      t.integer :status

      t.timestamps
    end
  end
end
