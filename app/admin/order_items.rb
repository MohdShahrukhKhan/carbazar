ActiveAdmin.register OrderItem do
  permit_params :order_id, :variant_id, :quantity, :price

  index do
    selectable_column
    id_column
    column :order
    column :variant
    column :quantity
    column :price
    actions
  end

  form do |f|
    f.inputs do
      f.input :order
      f.input :variant
      f.input :quantity
      f.input :price
    end
    f.actions
  end
end
