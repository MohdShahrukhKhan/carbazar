class FeatureSerializer < ActiveModel::Serializer
  attributes :id, :car_id, :city_mileage, :fuel_type, :engine_displacement, :no_of_cylinders, 
      :max_power, :max_torque, :seating_capacity, :transmission_type, :boot_space, 
      :fuel_tank_capacity, :body_type, :ground_clearance_unladen, :power_steering, 
      :abs, :air_conditioner, :driver_airbag, :passenger_airbag, :automatic_climate_control, 
      :alloy_wheels, :multi_function_steering_wheel, :engine_start_stop_button


              has_many :offers, if: -> { object.offers.any? }




end
