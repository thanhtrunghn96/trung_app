# frozen_string_literal: true

class RemoveToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :phone, :string
    remove_column :users, :address, :string
  end
end
