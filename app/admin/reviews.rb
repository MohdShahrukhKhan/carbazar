# app/admin/reviews.rb
ActiveAdmin.register Review do
  permit_params :rating, :comment, :user_id, :car_id, :variant_id

  index do
    selectable_column
    id_column
    column :rating
    column :comment
    column :user
    column :car
    column :variant
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Review Details' do
      f.input :user
      f.input :car
      f.input :variant
      f.input :rating, as: :select, collection: 1..5
      f.input :comment
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :rating
      row :comment
      row :user
      row :car
      row :variant
      row :created_at
      row :updated_at
    end
  end

  filter :rating
  filter :user
  filter :car
  filter :variant
  filter :created_at
end
