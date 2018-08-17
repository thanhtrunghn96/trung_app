# frozen_string_literal: true

class DropUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :users
  end
end
