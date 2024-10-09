ActiveAdmin.register OrderItem do
  permit_params :order_id, :variant_id, :quantity, :price

  index do
    selectable_column
    id_column
    column :order
    column :variant
    column :quantity
    column :price
  end

 
end
