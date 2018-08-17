# frozen_string_literal: true

class DeviseCreateUsers2 < ActiveRecord::Migration[5.2]
  def change
    create_table 'users', force: :cascade do |t|
      t.string 'email', default: '', null: false
      t.string 'encrypted_password', default: '', null: false
      t.string 'reset_password_token'
      t.datetime 'reset_password_sent_at'
      t.datetime 'remember_created_at'
      t.integer 'sign_in_count', default: 0, null: false
      t.datetime 'current_sign_in_at'
      t.datetime 'last_sign_in_at'
      t.string 'current_sign_in_ip'
      t.string 'last_sign_in_ip'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'name'
      t.string 'phone'
      t.string 'address'
      t.boolean 'approved', default: false, null: false
      t.string 'confirmation_token'
      t.datetime 'confirmed_at'
      t.datetime 'confirmation_sent_at'
      t.string 'unconfirmed_email'
      t.string 'avatar'
      t.index ['approved'], name: 'index_users_on_approved'
      t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
      t.index ['email'], name: 'index_users_on_email', unique: true
      t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    end
  end
end
