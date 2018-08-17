# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.where('name LIKE ?', "%#{params[:search]}%").page params[:page]
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

  def show; end

  def edit
    @category = Category.find_by(id: params[:id])
    render 'shared/_404' if @category.nil?
  end

  def update
    @category = Category.find_by(id: params[:id])
    render 'shared/_404' if @category.nil?

    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
