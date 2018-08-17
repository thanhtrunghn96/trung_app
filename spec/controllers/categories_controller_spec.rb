# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'TEST CATEGORY' do
    before do
      user.confirm
      sign_in user
    end
    it 'Render category index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'Render category new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'Render category index after create' do
      post :create, params: { category: { name: 'abc' } }
      expect(response).to redirect_to(categories_path)
    end

    it 'Render category new after fail create' do
      post :create, params: { category: { name: nil } }
      expect(response).to render_template(:new)
    end

    it 'Render category index after update' do
      category2 = FactoryBot.create(:category)
      patch :update, params: { category: { name: 'asus' }, id: category2.id }
      expect(response).to redirect_to(categories_path)
    end

    it 'Render category index after destroy' do
      category1 = FactoryBot.create(:category)
      delete :destroy, params: { id: category1.id }
      expect(response).to redirect_to(categories_path)
    end
  end
end
