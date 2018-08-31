# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:confirmable
  mount_uploader :avatar, AvatarUploader
  has_many :carts
  has_many :products
  validates :name, presence: true
  validates :phone, uniqueness: true, presence: true
  validates :address, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  def picture_size
    errors.add(:avatar, t('image_size')) if avatar.size > 5.megabytes
  end
end
