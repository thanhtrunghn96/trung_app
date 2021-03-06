# frozen_string_literal: true

ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  index do
    selectable_column
    column :id
    column 'Category' do |product|
      product.category.present? ? product.category.name : content_tag(:span, 'no category yet')
    end
    column :name
    column :price do |product|
      number_to_currency product.price
    end
    column 'Avatar', :image_link do |ad|
      image_tag ad.image_link.url, class: 'image_link_index'
    end
    column 'Description', :content
    column 'Seller', :user
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :category
      row :name
      row :price do |product|
        number_to_currency product.price
      end
      row 'Avatar', :image_link do |ad|
        image_tag ad.image_link.url,  class: 'image_link_view'
      end
      row 'Description', &:content
      row 'Seller', &:user
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  permit_params :category_id, :name, :price, :content, :image_link

  csv do
    column :id
    column :category
    column :name
    column :price
    column :image_link
    column :content
    column :user_id
    column :created_at
    column :updated_at
  end

  controller do
    def create
      @product = Product.create(permitted_params[:product])
      if @product.save
        flash[:success] = 'Add a new product success'
        redirect_to admin_products_path
      else
        flash[:danger] = 'Add a new failed'
        render :new
      end
    end
  end

  form do |f|
    f.inputs 'New Product' do
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
