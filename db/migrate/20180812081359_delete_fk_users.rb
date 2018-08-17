# frozen_string_literal: true

class DeleteFkUsers < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :transactions, column: :user_id
  end
end
