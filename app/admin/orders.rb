ActiveAdmin.register Order do
  permit_params :total_price, :status, :user_id, order_items_attributes: [:id, :variant_id, :quantity, :price, :_destroy]

  index do
    selectable_column
    id_column
    column :user
    column :total_price
    column :status
  end

  
end
