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


# ActiveAdmin.register Car do
#   permit_params :name, :body_type, :car_types, :brand_id, :launch_date, 
#                 variants_attributes: [:id, :variant, :price, :colour, :_destroy, 
#                 feature_attributes: [:id, :city_mileage, :fuel_type, :engine_displacement, 
#                                      :no_of_cylinders, :max_power, :max_torque, 
#                                      :seating_capacity, :transmission_type, :boot_space, 
#                                      :fuel_tank_capacity, :body_type, :power_steering, 
#                                      :abs, :air_conditioner, :driver_airbag, 
#                                      :passenger_airbag, :automatic_climate_control, 
#                                      :alloy_wheels, :multi_function_steering_wheel, 
#                                      :engine_start_stop_button, :_destroy]]

#   index do
#     selectable_column
#     id_column
#     column :name
#     column :brand
#     column :body_type
#     column :car_types
#     column :launch_date
   

#     # Display variants info in the index table
#     column "Variants" do |car|
#       ul do
#         car.variants.each do |variant|
#           li "#{variant.variant} - #{variant.price} - #{variant.colour}"
#         end
#       end
#     end

#     actions
#   end

#   form do |f|
#     f.semantic_errors

#     f.inputs 'Car Details' do
#       f.input :name
#       f.input :brand, as: :select, collection: Brand.all.map { |brand| [brand.name, brand.id] }
#       f.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
#       f.input :car_types, as: :select, collection: ['New Car', 'Upcoming Car']
#       f.input :launch_date, as: :datepicker
#     end

#     f.inputs 'Car Variants' do
#       f.has_many :variants, allow_destroy: true, new_record: true do |vf|
#         vf.input :variant
#         vf.input :price
#         vf.input :colour

#         # Add Feature fields within the Variant
#         vf.inputs 'Feature Details' do
#           vf.has_many :feature, allow_destroy: true, new_record: true do |ff|
#             ff.input :city_mileage
#             ff.input :fuel_type, as: :select, collection: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
#             ff.input :engine_displacement
#             ff.input :no_of_cylinders
#             ff.input :max_power
#             ff.input :max_torque
#             ff.input :seating_capacity
#             ff.input :transmission_type, as: :select, collection: ['Manual', 'Automatic', 'CVT', 'Dual-Clutch']
#             ff.input :boot_space
#             ff.input :fuel_tank_capacity
#             ff.input :body_type, as: :select, collection: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible']
#             ff.input :power_steering
#             ff.input :abs
#             ff.input :air_conditioner
#             ff.input :driver_airbag
#             ff.input :passenger_airbag
#             ff.input :automatic_climate_control
#             ff.input :alloy_wheels
#             ff.input :multi_function_steering_wheel
#             ff.input :engine_start_stop_button
#           end
#         end
#       end
#     end

#     f.actions
#   end

#   show do
#     attributes_table do
#       row :name
#       row :brand
#       row :body_type
#       row :car_types
#       row :launch_date
#     end

#     panel "Car Variants" do
#       table_for car.variants do
#         column :variant
#         column :price
#         column :colour

#         # Display associated Feature attributes in the show view
#         column "Feature Details" do |variant|
#           table_for variant.feature do
#             column :city_mileage
#             column :fuel_type
#             column :engine_displacement
#             column :no_of_cylinders
#             column :max_power
#             column :max_torque
#             column :seating_capacity
#             column :transmission_type
#             column :boot_space
#             column :fuel_tank_capacity
#             column :body_type
#             column :power_steering
#             column :abs
#             column :air_conditioner
#             column :driver_airbag
#             column :passenger_airbag
#             column :automatic_climate_control
#             column :alloy_wheels
#             column :multi_function_steering_wheel
#             column :engine_start_stop_button
#           end
#         end
#       end
#     end
#   end
# end

