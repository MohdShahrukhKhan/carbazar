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
    f.inputs 'Order Details' do
      f.input :user, as: :select, collection: User.all, include_blank: false # Assuming you have users to select from
      f.input :total_price
      f.input :status
    end

    f.inputs 'Order Items' do
      f.has_many :order_items, allow_destroy: true, new_record: true do |oi|
        oi.input :variant, as: :select, collection: Variant.all, include_blank: false # Assuming you have variants to select from
        oi.input :quantity
        oi.input :price
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :total_price
      row :status
    end

    panel "Order Items" do
      table_for order.order_items do
        column :variant
        column :quantity
        column :price
      end
    end
  end

  filter :user
  filter :total_price
  filter :status
  filter :created_at
end
