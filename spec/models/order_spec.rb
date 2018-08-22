# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:category) { FactoryBot.create(:category) }
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product, category: category) }
  let(:order) { FactoryBot.create(:order, product: product) }

  it 'is valid with valid attributes' do
    expect(order).to be_valid
  end

  it 'is not valid without quantity' do
    order.quantity = nil
    expect(order).to_not be_valid
  end

  it 'is not valid without quantity' do
    order.quantity = 0
    expect(order).to_not be_valid
  end
end
