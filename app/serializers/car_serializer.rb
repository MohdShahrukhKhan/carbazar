class CarSerializer < ActiveModel::Serializer
  attributes :id, :name, :body_type, :car_types, :brand_name, :dealer_name
  attribute :launch_date, if: :upcoming_car?

  has_many :variants, serializer: VariantSerializer

  # Serialize the brand name
  def brand_name
    object.brand&.name
  end

  # Serialize the dealer name (user name)
  def dealer_name
    object.user&.name  # Assuming the User model has a `name` attribute
  end

  # Check if the car is upcoming
  def upcoming_car?
    object.car_types == "Upcoming Car"  # Adjust this based on how you define an upcoming car
  end

  # # Add feature attributes for each variant, handling potential nil values
  # def features
  #   object.variants.map do |variant|
  #     if variant.feature.present?
  #       variant.feature.slice(
  #         :city_mileage,
  #         :fuel_type,
  #         :engine_displacement,
  #         :no_of_cylinders,
  #         :max_power,
  #         :max_torque,
  #         :seating_capacity,
  #         :transmission_type,
  #         :boot_space,
  #         :fuel_tank_capacity,
  #         :body_type,
  #         :ground_clearance_unladen,
  #         :power_steering,
  #         :abs,
  #         :air_conditioner,
  #         :driver_airbag,
  #         :passenger_airbag,
  #         :automatic_climate_control,
  #         :alloy_wheels,
  #         :multi_function_steering_wheel,
  #         :engine_start_stop_button
  #       )
  #     end
  #   end.compact # Use compact to avoid nil values
  # end

  # # Include feature attributes in the serialized output
  # attribute :features do
  #   features
  # end
end
