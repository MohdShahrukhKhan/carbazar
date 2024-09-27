# ActiveAdmin.register Feature do
#   permit_params :variant_name, :price, :colour, :city_mileage, :fuel_type, :engine_displacement, :no_of_cylinders,
#                 :max_power, :max_torque, :seating_capacity, :transmission_type,
#                 :boot_space, :fuel_tank_capacity, :body_type, :power_steering,
#                 :abs, :air_conditioner, :driver_airbag, :passenger_airbag,
#                 :automatic_climate_control, :alloy_wheels, :multi_function_steering_wheel,
#                 :engine_start_stop_button
# end

ActiveAdmin.register Feature do
  permit_params :variant_name, :price, :colour, :city_mileage, :fuel_type, 
                :engine_displacement, :no_of_cylinders, :max_power, :max_torque, 
                :seating_capacity, :transmission_type, :boot_space, 
                :fuel_tank_capacity, :body_type, :power_steering, 
                :abs, :air_conditioner, :driver_airbag, 
                :passenger_airbag, :automatic_climate_control, 
                :alloy_wheels, :multi_function_steering_wheel, 
                :engine_start_stop_button, :car_id

  filter :car, as: :select, collection: -> { Car.all.pluck(:name, :id) }

  index do
    selectable_column
    id_column
    column :car
    column :variant_name
    column :price
    column :fuel_type
    column :max_power
    column :seating_capacity
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs 'Feature Details' do
      f.input :car, as: :select, collection: Car.all.pluck(:name, :id)
      f.input :variant_name
      f.input :price
      f.input :colour
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

