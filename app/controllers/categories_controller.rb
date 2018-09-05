# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category_id, only: [:edit, :update, :destroy]
  def index
    @search = Category.ransack(params[:q])
    @category = @search.result(distinct: true).page params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Add a new category success'
      redirect_to categories_path
    else
      render :new
    end
  end

  def show
    @q = Product.ransack(params[:q])
    @category = Category.all
    @category1 = Category.find_by(id: params[:id])
    if @category1.nil?
      render 'shared/_404' if @category1.nil?
    else
      @products = @category1.products.page(params[:page]).per(9)
      render 'shared/_404' if @products.nil?
    end
  end

  def edit
    render 'shared/_404' if @category.nil?
  end

  def update
    render 'shared/_404' if @category.nil?
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category_id
    @category = Category.find_by(id: params[:id])
  end
end
