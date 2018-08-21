# frozen_string_literal: true

ActiveAdmin.register Category do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name
  controller do
    def create
      @category = Category.create(permitted_params[:category])
      if @category.save
        flash[:success] = 'Add a new category success'
        redirect_to admin_categories_path
      else
        render :new
      end
    end
  end
  form do |f|
    f.inputs 'New category' do
      f.input :name
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
end
