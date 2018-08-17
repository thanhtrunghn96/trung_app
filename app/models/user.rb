# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # has_many :carts
  validates :name, presence: true
  validates :phone, uniqueness: true, presence: true
  validates :address, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  # validates :password_confirmation, presence: true
end
