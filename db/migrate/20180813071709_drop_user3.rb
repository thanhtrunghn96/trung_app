# frozen_string_literal: true

class DropUser3 < ActiveRecord::Migration[5.2]
  def change
    drop_table :users
  end
end
