# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:category) { FactoryBot.create(:category) }
  let(:product) { FactoryBot.create(:product, category: category) }
  let(:order) { FactoryBot.create(:product) }
  describe 'TEST Orders' do
    it 'Redirect current cart after destroy' do
      @cart = order.cart_id
      delete :destroy, params: { id: order.id }
      expect(response).to redirect_to(cart_path(@cart))
    end
  end
end
