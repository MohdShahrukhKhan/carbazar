class VariantSerializer < ActiveModel::Serializer
  attributes :id, :variant, :price, :colour, :car_name, :brand_name, :feature_attributes

  # Serialize feature attributes if the variant has a feature
  def feature_attributes
    if object.feature.present?
      object.feature.slice(
        :city_mileage,
        :fuel_type,
        :engine_displacement,
        :no_of_cylinders,
        :max_power,
        :max_torque,
        :seating_capacity,
        :transmission_type,
        :boot_space,
        :fuel_tank_capacity,
        :body_type,
        :ground_clearance_unladen,
        :power_steering,
        :abs,
        :air_conditioner,
        :driver_airbag,
        :passenger_airbag,
        :automatic_climate_control,
        :alloy_wheels,
        :multi_function_steering_wheel,
        :engine_start_stop_button
      )
    else
      {}
    end
  end

  # Include car name and brand name in the attributes
  def car_name
    object.car&.name
  end

  def brand_name
    object.car&.brand&.name
  end
end



# class VariantSerializer < ActiveModel::Serializer
#   attributes :id, :variant, :price, :colour, :car_name, :brand_name

#   def car_name
#     object.car&.name
#   end

#   def brand_name
#     object.car&.brand&.name
#   end

#   # Include feature attributes separately
#   has_one :feature, key: :feature_attributes

#   def feature_attributes
#     return unless object.feature

#     object.feature.slice(
#       :city_mileage,
#       :fuel_type,
#       :engine_displacement,
#       :no_of_cylinders,
#       :max_power,
#       :max_torque,
#       :seating_capacity,
#       :transmission_type,
#       :boot_space,
#       :fuel_tank_capacity,
#       :body_type,
#       :ground_clearance_unladen,
#       :power_steering,
#       :abs,
#       :air_conditioner,
#       :driver_airbag,
#       :passenger_airbag,
#       :automatic_climate_control,
#       :alloy_wheels,
#       :multi_function_steering_wheel,
#       :engine_start_stop_button
#     )
#   end
# end
