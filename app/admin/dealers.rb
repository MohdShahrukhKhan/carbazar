ActiveAdmin.register Dealer do
  permit_params :name, :address, :contact_number, :brand_id

  # Filters for searching
  filter :name
  filter :address
  filter :contact_number
  filter :brand, as: :select, collection: -> { Brand.all.pluck(:name, :id) }

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :contact_number
    column :brand
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs 'Dealer Details' do
      f.input :name
      f.input :address
      f.input :contact_number
      f.input :brand, as: :select, collection: Brand.all.map { |b| [b.name, b.id] }
    end
    f.actions
  end
end
