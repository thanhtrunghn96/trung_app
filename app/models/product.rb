# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :orders
  belongs_to :category
  before_destroy :check_if_has_order
  mount_uploader :image_link,  ImageLinkUploader
  validates :name, uniqueness: true, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :content, presence: true
  validates :image_link, presence: true
  validates :category_id, presence: true, numericality: { only_integer: true }

  def self.order_list(sort_order)
    if sort_order == 'newest' || sort_order.blank?
      order(created_at: :desc)
    elsif sort_order == 'name'
      order(name: :asc)
    elsif sort_order == 'price'
      order(price: :desc)
    else
      order(created_at: :asc)
    end
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
