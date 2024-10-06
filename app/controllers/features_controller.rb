class FeaturesController < ApplicationController
def index
  # Use pagy for pagination with eager loading of offers
  pagy, features = pagy(Feature.all , items: 20)

  # Render JSON using the FeatureSerializer with pagination metadata
  render json: {
    features: ActiveModelSerializers::SerializableResource.new(features, each_serializer: FeatureSerializer),
    meta: pagination_metadata(pagy)
  }
end


def create
    @feature = Feature.new(feature_params)

    if @feature.save
      render json: @feature, status: :created
    else
      render json: @feature.errors, status: :unprocessable_entity
    end
  end

  
  private

  # Strong parameters to whitelist feature attributes for update
  def feature_params
   params.require(:feature).permit(
      :variant_id, :city_mileage, :fuel_type, :engine_displacement, :no_of_cylinders, 
      :max_power, :max_torque, :seating_capacity, :transmission_type, :boot_space, 
      :fuel_tank_capacity, :body_type, :ground_clearance_unladen, :power_steering, 
      :abs, :air_conditioner, :driver_airbag, :passenger_airbag, :automatic_climate_control, 
      :alloy_wheels, :multi_function_steering_wheel, :engine_start_stop_button
    )
  end 


  
end
