# ActiveAdmin.register Car do
#   permit_params :name, :body_type, :car_types, :brand_id, :launch_date, feature_attributes: [
#     :id, :variant_name, :price, :colour, :city_mileage, :fuel_type, 
#     :engine_displacement, :no_of_cylinders, :max_power, :max_torque, 
#     :seating_capacity, :transmission_type, :boot_space, :fuel_tank_capacity, 
#     :body_type, :power_steering, :abs, :air_conditioner, 
#     :driver_airbag, :passenger_airbag, :automatic_climate_control, 
#     :alloy_wheels, :multi_function_steering_wheel, :engine_start_stop_button
#   ]

#   form do |f|
#     f.semantic_errors # Shows errors on :base
#     f.inputs 'Car Details' do
#       f.input :name
#       f.input :brand, as: :select, collection: Brand.all.map { |brand| [brand.name, brand.id] }
#       f.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
#       f.input :car_types, as: :select, collection: ['New Car', 'Upcoming Car'], input_html: { id: 'car_types_select' }
#       f.input :launch_date, input_html: { class: 'launch-date-field' }
#     end
#     f.inputs 'Car Features & Variant', for: [:feature, f.object.features.build] do |ff|

#     #f.inputs 'Car Features & Variant', for: [:feature, f.object.feature || Feature.new] do |ff|
#       ff.input :variant_name
#       ff.input :price
#       ff.input :colour
#       ff.input :city_mileage
#       ff.input :fuel_type, as: :select, collection: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
#       ff.input :engine_displacement
#       ff.input :no_of_cylinders
#       ff.input :max_power
#       ff.input :max_torque
#       ff.input :seating_capacity
#       ff.input :transmission_type, as: :select, collection: ['Manual', 'Automatic', 'CVT', 'Dual-Clutch']
#       ff.input :boot_space
#       ff.input :fuel_tank_capacity
#       ff.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
#       ff.input :power_steering
#       ff.input :abs, label: 'Anti-lock Braking System (ABS)'
#       ff.input :air_conditioner
#       ff.input :driver_airbag
#       ff.input :passenger_airbag
#       ff.input :automatic_climate_control
#       ff.input :alloy_wheels
#       ff.input :multi_function_steering_wheel
#       ff.input :engine_start_stop_button
#     end
#     f.actions
#   end

#   # Filters should be defined outside the form block
#   filter :brand, as: :select, collection: -> { Brand.all.map { |brand| [brand.name, brand.id] } }



#   # Controller customization
#   controller do
#     def edit
#       @car = Car.find(params[:id])
#       render 'edit'
#     end
#   end
# end

ActiveAdmin.register Car do
  permit_params :name, :body_type, :car_types, :brand_id, :launch_date, 
                features_attributes: [
                  :id, :variant_name, :price, :colour, :city_mileage, :fuel_type, 
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
              
                  # Display the associated features
                  column "Features" do |car|
                    car.features.map { |feature| feature.variant_name }.join(", ")
                  end
              
                  actions
                end

  form do |f|
    f.semantic_errors # Shows errors on :base
    
    # Car details
    f.inputs 'Car Details' do
      f.input :name
      f.input :brand, as: :select, collection: Brand.all.map { |brand| [brand.name, brand.id] }
      f.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
      f.input :car_types, as: :select, collection: ['New Car', 'Upcoming Car']
      f.input :launch_date, as: :datepicker
    
    end

    # Nested features form
    f.inputs 'Car Features & Variants' do
      f.has_many :features, allow_destroy: true, new_record: true do |ff|
        ff.input :variant_name
        ff.input :price
        ff.input :colour
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
        ff.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
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

  # Show page with associated features
  show do
    attributes_table do
      row :name
      row :brand
      row :body_type
      row :car_types
      row :launch_date
      row :created_at
      row :updated_at

      # Display associated feature details
      panel 'Feature Details' do
        table_for car.features do
          column :variant_name
          column :price
          column :colour
          column :city_mileage
          column :fuel_type
          column :engine_displacement
          column :no_of_cylinders
          column :max_power
          column :max_torque
          column :seating_capacity
          column :transmission_type
          column :boot_space
          column :fuel_tank_capacity
          column :power_steering
          column :abs
          column :air_conditioner
          column :driver_airbag
          column :passenger_airbag
          column :automatic_climate_control
          column :alloy_wheels
          column :multi_function_steering_wheel
          column :engine_start_stop_button
        end
      end
    end

    active_admin_comments
  end

  # Controller customization
  controller do
    def show
      @car = Car.find(params[:id])
    end
  end
end
