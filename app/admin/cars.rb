ActiveAdmin.register Car do
  permit_params :name, :body_type, :car_types, :brand_id, :launch_date, 
                variants_attributes: [:id, :variant, :price, :colour, :_destroy]
                
                
  index do
    selectable_column
    id_column
    column :name
    column :brand
    column :body_type
    column :car_types
    column :launch_date

    # Display variants info in the index table
    column "Variants" do |car|
      ul do
        car.variants.each do |variant|
          li "#{variant.variant} - #{variant.price} - #{variant.colour}"
        end
      end
    end

    actions
  end

  form do |f|
    f.semantic_errors # Show errors on :base

    # Car details
    f.inputs 'Car Details' do
      f.input :name
      f.input :brand, as: :select, collection: Brand.all.map { |brand| [brand.name, brand.id] }
      f.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
      f.input :car_types, as: :select, collection: ['New Car', 'Upcoming Car'], input_html: { id: 'car_car_types' } # Add ID for JS
      f.input :launch_date, as: :datepicker, input_html: { id: 'car_launch_date_input' } # Add ID for JS
    end

    # Nested variants form
    f.inputs 'Car Variants' do
      f.has_many :variants, allow_destroy: true, new_record: true do |vf|
        vf.input :variant
        vf.input :price
        vf.input :colour
      end
    end

  

    f.actions
  end

  # Filters
  filter :brand, as: :select, collection: -> { Brand.all.map { |brand| [brand.name, brand.id] } }

  # Show page with associated variants
  show do
    attributes_table do
      row :name
      row :brand
      row :body_type
      row :car_types
      row :launch_date
    end

    # Panel for Variants
    panel "Car Variants" do
      table_for car.variants do
        column :variant
        column :price
        column :colour
      end
    end

    
  end

  # Controller customization
  controller do
    def show
      @car = Car.find(params[:id])
    end
  end
end

