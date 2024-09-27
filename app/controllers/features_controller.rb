# 

class FeaturesController < ApplicationController

  # API to get all features
  def index
    features = Feature.all
    render json: features.map { |feature|
      {
        id: feature.id,
        variant_name: feature.variant_name,
        price: feature.price.to_f,
        discounted_price: feature.discounted_price,
        offers: feature.offers.map { |offer| { offer_name: offer.offer_name, discount: offer.discount } }
      }
    }
  end
  
def show
  feature = Feature.find(params[:id])
  saves = feature.price.to_f - feature.discounted_price.to_f 

  render json: {
    id: feature.id,
    variant_name: feature.variant_name,
    price: feature.price,
    discounted_price: feature.discounted_price,
    saves: saves, 
    offers: feature.offers.map { |offer| { offer_name: offer.offer_name, discount: offer.discount } }
  }
end


  # Update feature attributes
  def update
    feature = Feature.find(params[:id])
  
    if feature.update(feature_params)
      render json: {
        status: 'SUCCESS',
        message: 'Feature was successfully updated.',
        data: feature
      }, status: :ok
    else
      render json: {
        status: 'ERROR',
        message: 'Feature update failed.',
        errors: feature.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
  

  private

  # Strong parameters to whitelist feature attributes for update
  def feature_params
    params.require(:feature).permit(:city_mileage, :fuel_type, :engine_displacement, :no_of_cylinders,
                                    :max_power, :max_torque, :seating_capacity, :transmission_type,
                                    :boot_space, :fuel_tank_capacity, :body_type, :power_steering,
                                    :abs, :air_conditioner, :driver_airbag, :passenger_airbag,
                                    :automatic_climate_control, :alloy_wheels, :multi_function_steering_wheel,
                                    :engine_start_stop_button)
  end
end
