# frozen_string_literal: true

ActiveAdmin.register Cart do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  controller do |cart|
    def show
      cart = Cart.find_by(id: params[:id])
      respond_to do |format|
        format.html
        format.csv { send_data cart.orders.to_csv,filename: "details-#{Date.today}.csv"}
      end
    end
  end

  show do |cart|
    panel 'Customer details' do
      attributes_table_for cart, :user, :totalprice, :status, :updated_at
    end

    panel('Order details') do
      table_for(cart.orders) do
        column 'Product' do |f|
          f.product.name
        end
        column 'Price' do |f|
          number_to_currency f.product.price
        end
        column 'Quantity', &:quantity
      end
    end
    text_node link_to('Download CSV', admin_cart_path(resource.id, format: :csv))
  end

  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
