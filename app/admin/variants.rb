ActiveAdmin.register Variant do
  permit_params :variant, :price, :colour, :car_id

  # Define filters
  filter :car, as: :select, collection: -> { Car.all.pluck(:name, :id) }

  index do
    selectable_column
    id_column
    column :variant
    column :price
    column :colour
    column :car
    column :offers do |variant|
      variant.offers.map(&:offer_name).join(', ') # Assuming you have an offer_name attribute
    end
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs 'Variant Details' do
      f.input :variant
      f.input :price
      f.input :colour
      f.input :car, as: :select, collection: Car.all.pluck(:name, :id)
    end
    f.actions
  end
end
