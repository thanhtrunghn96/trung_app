# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { FactoryBot.create(:category) }
  let!(:product) { FactoryBot.create(:product, category: category, name: 'abc') } # !
  describe 'Validates' do
    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product.name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product.price = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a content' do
      product.content = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a image_link' do
      product.image_link = nil
      expect(product).to_not be_valid
    end
    context 'should validate name uniqueness' do
      let(:product1) { FactoryBot.build(:product, category: category, name: 'abc') }
      it do
        product1.valid?
        expect(product1.errors.full_messages).to include 'Name has already been taken'
      end
    end
  end
end
