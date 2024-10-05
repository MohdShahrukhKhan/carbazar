# class CreateFeatures < ActiveRecord::Migration[7.0]
#   def change
#     create_table :features do |t|
#       # Key Specifications
#       t.string :variant_name
#       t.string :price
#       t.string :colour
#       t.string :city_mileage
#       t.string :fuel_type
#       t.integer :engine_displacement
#       t.integer :no_of_cylinders
#       t.string :max_power
#       t.string :max_torque
#       t.integer :seating_capacity
#       t.string :transmission_type
#       t.integer :boot_space
#       t.integer :fuel_tank_capacity
#       t.string :body_type
#       t.integer :ground_clearance_unladen
      
#       # Key Features
#       t.boolean :power_steering
#       t.boolean :abs
#       t.boolean :air_conditioner
#       t.boolean :driver_airbag
#       t.boolean :passenger_airbag
#       t.boolean :automatic_climate_control
#       t.boolean :alloy_wheels
#       t.boolean :multi_function_steering_wheel
#       t.boolean :engine_start_stop_button

#       t.timestamps
#     end
#   end
# end

class CreateFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :features do |t|
      t.integer :car_id
      t.integer :variant_id
      t.string :city_mileage
      t.string :fuel_type
      t.integer :engine_displacement
      t.integer :no_of_cylinders
      t.string :max_power
      t.string :max_torque
      t.integer :seating_capacity
      t.string :transmission_type
      t.integer :boot_space
      t.integer :fuel_tank_capacity
      t.string :body_type
      t.integer :ground_clearance_unladen
      
      # Key Features
      t.boolean :power_steering
      t.boolean :abs
      t.boolean :air_conditioner
      t.boolean :driver_airbag
      t.boolean :passenger_airbag
      t.boolean :automatic_climate_control
      t.boolean :alloy_wheels
      t.boolean :multi_function_steering_wheel
      t.boolean :engine_start_stop_button

      t.timestamps
    end
  end
end

