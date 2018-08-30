class AddToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :product_name, :string
    add_column :orders, :product_price, :decimal
  end
end
