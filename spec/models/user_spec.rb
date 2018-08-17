# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user, name: 'trung', email: 'abc@gmail.com', phone: '092173') }

  describe 'Validates' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a phone' do
      user.phone = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a address' do
      user.address = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a email' do
      user.email = nil
      expect(user).to_not be_valid
    end
    context 'should validate name uniqueness' do
      let(:user1) { FactoryBot.build(:user, name: 'trung') }
      it do
        user1.valid?
        expect(category1.errors.full_messages).to include 'Name has already been taken'
      end
    end
    context 'should validate phone uniqueness' do
      let(:user2) { FactoryBot.build(:user, email: 'abc@gmail.com') }
      it do
        user2.valid?
        expect(category1.errors.full_messages).to include 'Email has already been taken'
      end
    end
    context 'should validate phone uniqueness' do
      let(:user3) { FactoryBot.build(:category, name: '092173') }
      it do
        user3.valid?
        expect(category1.errors.full_messages).to include 'Phone has already been taken'
      end
    end
  end
end
