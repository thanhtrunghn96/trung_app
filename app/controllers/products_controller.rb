# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product_id, only: [:update, :show, :destroy]
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
    if @product.nil?
      render 'shared/_404'
    else
      @check_user = @product.user_id
    end
  end

  def edit
    @product1 = Product.find_by(id: params[:id])
    return render 'shared/_404' if @product1.nil?
    @check_user = @product1.user_id
    if @check_user == current_user.id
      @product = @product1
    else
      render 'shared/_404'
    end
  end

  def update
    return render 'shared/_404' if @product.nil?
    if @product.update(product_params)
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path }
      format.json { render }
    end
  end

  private

  def product_params
    params.require(:product).permit(:category_id, :name, :price, :content, :image_link)
  end

  def find_product_id
    @product = Product.find_by(id: params[:id])
  end
end
