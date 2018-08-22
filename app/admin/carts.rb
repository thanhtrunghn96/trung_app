# frozen_string_literal: true

ActiveAdmin.register Cart do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  show do |order|
    panel 'Customer details' do
      attributes_table_for cart, :user, :totalprice, :status, :updated_at
    end

    panel('Order details') do
      table_for(cart.orders) do
        column 'Product' do |f|
          f.product.name
        end
        column 'Price' do |f|
          f.product.price
        end
        column 'Quantity', &:quantity
      end
    end
  text_node link_to 'Download CSV', admin_carts_path(q: {id_eq: resource.id}, format: :csv)
  end

  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
