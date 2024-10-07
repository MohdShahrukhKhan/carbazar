ActiveAdmin.register Order do
  permit_params :total_price, :status, :user_id, order_items_attributes: [:id, :variant_id, :quantity, :price, :_destroy]

  index do
    selectable_column
    id_column
    column :user
    column :total_price
    column :status
    actions
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :total_price
      f.input :status
      f.has_many :order_items, allow_destroy: true do |oi|
        oi.input :variant
        oi.input :quantity
        oi.input :price
      end
    end
    f.actions
  end
end
