# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.page(params[:page]).per(9)
    @category = Category.all
  end
end
