# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { FactoryBot.create(:category, name: 'asus') } # "!"

  describe 'Validates' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category.name = nil
      expect(category).to_not be_valid
    end
    context 'should validate name uniqueness' do
      let(:category1) { FactoryBot.build(:category, name: 'asus') }
      it do
        category1.valid?
        expect(category1.errors.full_messages).to include 'Name has already been taken'
      end
    end
  end
end
