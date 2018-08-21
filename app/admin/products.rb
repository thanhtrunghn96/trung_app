# frozen_string_literal: true

ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :category_id, :name, :price, :content, :image_link
  controller do
    def create
      @product = Product.create(permitted_params[:product])
      if @product.save
        flash[:success] = 'Add a new product success'
        redirect_to admin_products_path
      else
        flash[:success] = 'Add a new failed'
        render :new
      end
    end
  end
  form do |f|
    f.inputs 'New category' do
      f.input :category
      f.input :name
      f.input :price
      f.input :content
      f.input :image_link
    end
    actions
  end
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  # index do
  #   column :name
  #   column :category
  #   column :price do |product|
  #     number_to_currency product.price, :unit => "&pound;"
  #   end
  # end
end
