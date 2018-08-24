class PagesController < ApplicationController
  before_action :authenticate_user!
 
  def index
    @search = Product.ransack(params[:q])
    @products = @search.result.eager_load(:category).page params[:page]
    @category = Category.all
  end
  
end
