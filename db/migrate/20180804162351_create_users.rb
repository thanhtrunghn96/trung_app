# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :user_name
      t.string :password_digest
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
