# frozen_string_literal: true

class AddToUsers < ActiveRecord::Migration[5.2]
  def change
  # add_column :users, :user_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
  end
end
