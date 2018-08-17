# frozen_string_literal: true

class DropUser < ActiveRecord::Migration[5.2]
  def change
    drop_table :users
  end
end
