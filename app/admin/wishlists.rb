ActiveAdmin.register Wishlist do
  # Permit parameters for user_id, car_id, and variant_id
  permit_params :user_id, :car_id, :variant_id

  # Index action to display a table of wishlists
  index do
    selectable_column
    id_column
    column :user
    column :car
    column :variant
    actions
  end

  # Show action to display details for a specific wishlist
  show do
    attributes_table do
      row :id
      row :user
      row :car
      row :variant
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
