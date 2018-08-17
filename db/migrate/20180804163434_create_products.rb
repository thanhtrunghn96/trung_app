# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.decimal :price
      t.integer :discount
      t.string :image_link
      t.text :image_list
      t.integer :view
      t.text :content

      t.timestamps
    end
  end
end
