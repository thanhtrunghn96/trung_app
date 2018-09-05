# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product_id, only: [:update, :destroy, :edit]
  def index
    @search = current_user.products.ransack(params[:search])
    @products = @search.result.includes(:category).page(params[:page]).per(9)
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = 'Add a new product success'
      redirect_to products_path
    else
      flash[:danger] = 'Add a new failed'
      render :new
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      render 'shared/_404'
    else
      @check_user = @product.user_id
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:category_id, :name, :price, :content, :image_link)
  end

  def find_product_id
    @product = current_user.products.find_by(id: params[:id])
    render 'shared/_404' if @product.nil?
  end
end
