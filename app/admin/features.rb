



# ActiveAdmin.register Feature do
#   # Permit the necessary parameters
#   permit_params :variant_id, :car_id, :city_mileage, :fuel_type, :engine_displacement, 
#                 :no_of_cylinders, :max_power, :max_torque, :seating_capacity, 
#                 :transmission_type, :boot_space, :fuel_tank_capacity, :body_type, 
#                 :power_steering, :abs, :air_conditioner, :driver_airbag, 
#                 :passenger_airbag, :automatic_climate_control, :alloy_wheels, 
#                 :multi_function_steering_wheel, :engine_start_stop_button

#   # Customize the index page
#   index do
#     selectable_column
#     id_column
#     column :car
#     column :fuel_type
#     column :max_power
#     column :seating_capacity
#     actions # This automatically provides show, edit, and delete actions
#   end

#   # Customize the show page
#   show do
#     attributes_table do
#       row :car
#       row :variant
#       row :city_mileage
#       row :fuel_type
#       row :engine_displacement
#       row :no_of_cylinders
#       row :max_power
#       row :max_torque
#       row :seating_capacity
#       row :transmission_type
#       row :boot_space
#       row :fuel_tank_capacity
#       row :body_type
#       row :power_steering
#       row :abs
#       row :air_conditioner
#       row :driver_airbag
#       row :passenger_airbag
#       row :automatic_climate_control
#       row :alloy_wheels
#       row :multi_function_steering_wheel
#       row :engine_start_stop_button
#       row :created_at
#       row :updated_at
#     end
#   end

#   # Customize the form
#   form do |f|
#     f.semantic_errors
#     f.inputs 'Feature Details' do
#       f.input :variant_id
#       f.input :city_mileage
#       f.input :fuel_type, as: :select, collection: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
#       f.input :engine_displacement
#       f.input :no_of_cylinders
#       f.input :max_power
#       f.input :max_torque
#       f.input :seating_capacity
#       f.input :transmission_type, as: :select, collection: ['Manual', 'Automatic', 'CVT', 'Dual-Clutch']
#       f.input :boot_space
#       f.input :fuel_tank_capacity
#       f.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
#       f.input :power_steering
#       f.input :abs, label: 'Anti-lock Braking System (ABS)'
#       f.input :air_conditioner
#       f.input :driver_airbag
#       f.input :passenger_airbag
#       f.input :automatic_climate_control
#       f.input :alloy_wheels
#       f.input :multi_function_steering_wheel
#       f.input :engine_start_stop_button
#       f.input :car, as: :select, collection: Car.all.pluck(:name, :id)
#     end
#     f.actions
#   end
# end

ActiveAdmin.register Feature do
  # Permit the necessary parameters
  permit_params :variant_id, :car_id, :city_mileage, :fuel_type, 
                :engine_displacement, :no_of_cylinders, :max_power, 
                :max_torque, :seating_capacity, :transmission_type, 
                :boot_space, :fuel_tank_capacity, :body_type, 
                :power_steering, :abs, :air_conditioner, 
                :driver_airbag, :passenger_airbag, 
                :automatic_climate_control, :alloy_wheels, 
                :multi_function_steering_wheel, :engine_start_stop_button

  # Customize the index page
  index do
    selectable_column
    id_column
    column :car
    column :variant
    column :fuel_type
    column :max_power
    column :seating_capacity
    actions
  end

  # Customize the show page
  show do
    attributes_table do
      row :car
      row :variant
      row :city_mileage
      row :fuel_type
      row :engine_displacement
      row :no_of_cylinders
      row :max_power
      row :max_torque
      row :seating_capacity
      row :transmission_type
      row :boot_space
      row :fuel_tank_capacity
      row :body_type
      row :power_steering
      row :abs
      row :air_conditioner
      row :driver_airbag
      row :passenger_airbag
      row :automatic_climate_control
      row :alloy_wheels
      row :multi_function_steering_wheel
      row :engine_start_stop_button
      row :created_at
      row :updated_at
    end
  end

  # Customize the form
  form do |f|
    f.semantic_errors
    f.inputs 'Feature Details' do
      f.input :car, as: :select, collection: Car.all.pluck(:name, :id), include_blank: false
      f.input :variant, as: :select, collection: Variant.all.pluck(:name, :id), include_blank: false
      f.input :city_mileage
      f.input :fuel_type, as: :select, collection: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
      f.input :engine_displacement
      f.input :no_of_cylinders
      f.input :max_power
      f.input :max_torque
      f.input :seating_capacity
      f.input :transmission_type, as: :select, collection: ['Manual', 'Automatic', 'CVT', 'Dual-Clutch']
      f.input :boot_space
      f.input :fuel_tank_capacity
      f.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
      f.input :power_steering
      f.input :abs, label: 'Anti-lock Braking System (ABS)'
      f.input :air_conditioner
      f.input :driver_airbag
      f.input :passenger_airbag
      f.input :automatic_climate_control
      f.input :alloy_wheels
      f.input :multi_function_steering_wheel
      f.input :engine_start_stop_button
    end
    f.actions
  end
end
