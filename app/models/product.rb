# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :orders
  belongs_to :category
  belongs_to :user
  before_destroy :check_if_has_order
  mount_uploader :image_link,  ImageLinkUploader
  validates :name, uniqueness: true, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :content, presence: true
  validates :image_link, presence: true
  validates :category_id, presence: true, numericality: { only_integer: true }

  def picture_size
    errors.add(:image_link, t('image_size')) if image_link.size > 5.megabytes
  end

  private

  def check_if_has_order
    if orders.empty?
      true
    else
      errors.add(:base, 'This product has a Order')
      false
    end
  end
end
