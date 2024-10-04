ActiveAdmin.register Car do
  permit_params :name, :body_type, :car_types, :brand_id, :launch_date, 
                variants_attributes: [:id, :variant_name, :price, :colour, :car_id],
                features_attributes: [
                  :id, :city_mileage, :car_id, :fuel_type, 
                  :engine_displacement, :no_of_cylinders, :max_power, :max_torque, 
                  :seating_capacity, :transmission_type, :boot_space, :fuel_tank_capacity, 
                  :body_type, :power_steering, :abs, :air_conditioner, 
                  :driver_airbag, :passenger_airbag, :automatic_climate_control, 
                  :alloy_wheels, :multi_function_steering_wheel, :engine_start_stop_button, 
                  :_destroy
                ]


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
      f.input :car_types, as: :select, collection: ['New Car', 'Upcoming Car']
      f.input :launch_date, as: :datepicker
    end

    # Nested variants form
    f.inputs 'Car Variants' do
      f.has_many :variants, allow_destroy: true, new_record: true do |vf|
        vf.input :variant
        vf.input :price
        vf.input :colour
      end
    end

    # Nested features form
    f.inputs 'Car Features' do
      f.has_many :features, allow_destroy: true, new_record: true do |ff|

        
        ff.input :city_mileage
        ff.input :fuel_type, as: :select, collection: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
        ff.input :engine_displacement
        ff.input :no_of_cylinders
        ff.input :max_power
        ff.input :max_torque
        ff.input :seating_capacity
        ff.input :transmission_type, as: :select, collection: ['Manual', 'Automatic', 'CVT', 'Dual-Clutch']
        ff.input :boot_space
        ff.input :fuel_tank_capacity
        ff.input :power_steering
        ff.input :abs, label: 'Anti-lock Braking System (ABS)'
        ff.input :air_conditioner
        ff.input :driver_airbag
        ff.input :passenger_airbag
        ff.input :automatic_climate_control
        ff.input :alloy_wheels
        ff.input :multi_function_steering_wheel
        ff.input :engine_start_stop_button
      end
    end

    f.actions
  end

  # Filters
  filter :brand, as: :select, collection: -> { Brand.all.map { |brand| [brand.name, brand.id] } }

  # Show page with associated features and variants
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

    # Panel for Features
    panel "Car Features" do
      table_for car.features do
        column :city_mileage
        column :fuel_type
        column :engine_displacement
        column :max_power
        column :seating_capacity
        column :transmission_type
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
