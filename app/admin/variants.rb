# # ActiveAdmin.register Variant do
# #   permit_params :variant, :price, :colour, :car_id, :quantity

# #   # Define filters
# #   filter :car, as: :select, collection: -> { Car.all.pluck(:name, :id) }

# #   index do
# #     selectable_column
# #     id_column
# #     column :variant
# #     column :price
# #     column :colour
# #     column :car
# #     column :offers do |variant|
# #       variant.offers.map(&:offer_name).join(', ') # Assuming you have an offer_name attribute
# #     end
# #     column :quantity
# #     actions
# #   end

# #   form do |f|
# #     f.semantic_errors
# #     f.inputs 'Variant Details' do
# #       f.input :variant
# #       f.input :price
# #       f.input :colour
# #       f.input :car, as: :select, collection: Car.all.pluck(:name, :id)
# #       f.input :quantity
# #     end
# #     f.actions
# #   end
# # end


# ActiveAdmin.register Variant do
#   permit_params :variant, :price, :colour, :car_id, :quantity,
#                 features_attributes: [
#                   :id, :city_mileage, :fuel_type, 
#                   :engine_displacement, :no_of_cylinders, :max_power, 
#                   :max_torque, :seating_capacity, :transmission_type, 
#                   :boot_space, :fuel_tank_capacity, :body_type, 
#                   :power_steering, :abs, :air_conditioner, 
#                   :driver_airbag, :passenger_airbag, 
#                   :automatic_climate_control, :alloy_wheels, 
#                   :multi_function_steering_wheel, :engine_start_stop_button, 
#                   :_destroy
#                 ]

#   # Define filters
#   filter :car, as: :select, collection: -> { Car.all.pluck(:name, :id) }

#   index do
#     selectable_column
#     id_column
#     column :variant
#     column :price
#     column :colour
#     column :car
#     column :offers do |variant|
#       variant.offers.map(&:offer_name).join(', ') # Assuming you have an offer_name attribute
#     end
#     column :quantity
#     actions
#   end

#   form do |f|
#     f.semantic_errors
#     f.inputs 'Variant Details' do
#       f.input :variant
#       f.input :price
#       f.input :colour
#       f.input :car, as: :select, collection: Car.all.pluck(:name, :id)
#       f.input :quantity
#     end

#     # Nested features form
#     f.inputs 'Feature Details' do
#       f.has_many :features, allow_destroy: true, new_record: true do |ff|
#         ff.input :city_mileage
#         ff.input :fuel_type, as: :select, collection: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
#         ff.input :engine_displacement
#         ff.input :no_of_cylinders
#         ff.input :max_power
#         ff.input :max_torque
#         ff.input :seating_capacity
#         ff.input :transmission_type, as: :select, collection: ['Manual', 'Automatic', 'CVT', 'Dual-Clutch']
#         ff.input :boot_space
#         ff.input :fuel_tank_capacity
#         ff.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
#         ff.input :power_steering
#         ff.input :abs, label: 'Anti-lock Braking System (ABS)'
#         ff.input :air_conditioner
#         ff.input :driver_airbag
#         ff.input :passenger_airbag
#         ff.input :automatic_climate_control
#         ff.input :alloy_wheels
#         ff.input :multi_function_steering_wheel
#         ff.input :engine_start_stop_button
#       end
#     end

#     f.actions
#   end
# end

ActiveAdmin.register Variant do
  permit_params :variant, :price, :colour, :car_id, :quantity,
                feature_attributes: [ # Change from features_attributes to feature_attributes
                  :id, :city_mileage, :fuel_type, 
                  :engine_displacement, :no_of_cylinders, :max_power, 
                  :max_torque, :seating_capacity, :transmission_type, 
                  :boot_space, :fuel_tank_capacity, :body_type, 
                  :power_steering, :abs, :air_conditioner, 
                  :driver_airbag, :passenger_airbag, 
                  :automatic_climate_control, :alloy_wheels, 
                  :multi_function_steering_wheel, :engine_start_stop_button, 
                  :_destroy
                ]

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
    column :quantity
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs 'Variant Details' do
      f.input :variant
      f.input :price
      f.input :colour
      f.input :car, as: :select, collection: Car.all.pluck(:name, :id)
      f.input :quantity
    end

    # Nested feature form
    f.inputs 'Feature Details' do
      f.semantic_errors
      f.has_many :feature, allow_destroy: true, new_record: true do |ff| # Change `features` to `feature`
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
end
