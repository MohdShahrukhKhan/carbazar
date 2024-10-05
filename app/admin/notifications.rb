ActiveAdmin.register Notification do
  permit_params :user_id, :booking_id, :message, :read # Include other relevant attributes

  index do
    selectable_column
    id_column
    column :user
    column :booking
    column :message
    column :read
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :user
      row :booking
      row :message
      row :read
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :booking
      f.input :message
      f.input :read
    end
    f.actions
  end
end
