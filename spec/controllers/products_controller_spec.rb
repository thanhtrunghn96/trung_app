# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:category) { FactoryBot.create(:category) }
  let(:product) { FactoryBot.create(:product, category: category) }
  describe 'TEST PRODUCT' do
    it 'Render product index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'Render product new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'Render category index after create' do
      post :create, params: { product: { name: product.name, price: product.price, content: product.content, image_link: product.image_link, category_id: category.id } }
      expect(response).to redirect_to(products_path)
    end

    it 'Render product index' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_path)
    end

    it 'render product show' do
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end

    it 'Render category index after update' do
      product1 = FactoryBot.create(:product, category: category)
      patch :update, params: { product: { name: product.name, price: product.price, content: product.content, image_link: product.image_link, category_id: category.id }, id: product1.id }
      expect(response).to redirect_to(products_path)
    end
  end
end
