# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    @product = if params[:search].nil?
                 Product.all.order_list(params[:sort_by]).page params[:page]
               else
                 Product.where('name LIKE ?', "%#{params[:search]}%").page params[:page]
               end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = 'Add a new product success'
      redirect_to products_path
    else
      flash[:success] = 'Add a new failed'
      render :new
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    render 'shared/_404' if @product.nil?
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render 'shared/_404' if @product.nil?
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
