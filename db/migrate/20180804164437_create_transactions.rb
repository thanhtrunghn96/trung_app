# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.integer :status
      t.decimal :amount
      t.string :payment
      t.text :payment_info
      t.string :message
      t.string :security

      t.timestamps
    end
  end
end
