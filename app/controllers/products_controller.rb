# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    @q = current_user.products.ransack(params[:q])
    @products = @q.result.includes(:category).page(params[:page]).per(9)
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = 'Add a new product success'
      redirect_to products_path
    else
      flash[:success] = 'Add a new failed'
      render :new
    end
  end

  def show
    @q = Product.ransack(params[:q])
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      render 'shared/_404'
    else
      @check_user = @product.user_id
    end
  end

  def edit
    @product1 = Product.find_by(id: params[:id])
    if @product1.nil?
      render 'shared/_404'
    else
      @check_user = @product1.user_id
      if @check_user == current_user.id
        @product = @product1
      else
        render 'shared/_404'
      end
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    render 'shared/_404' if @product.nil?

    if @product.update(product_params)
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:category_id, :name, :price, :content, :image_link)
  end
end
