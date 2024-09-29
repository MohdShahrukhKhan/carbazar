class FeaturesController < ApplicationController

  # API to get all features
  def index
    features = Feature.all
    render json: features.map { |feature|
      {
        id: feature.id,
        variant_name: feature.variant_name,
        price: feature.price.to_f,
        offers: feature.offers.map { |offer| { offer_name: offer.offer_name, discount: offer.discount } }
      }
    }
  end

  def show
    feature = Feature.find(params[:id])

    render json: {
      id: feature.id,
      variant_name: feature.variant_name,
      price: feature.price.to_f,
      offers: feature.offers.map { |offer| { offer_name: offer.offer_name, discount: offer.discount } }
    }
  end

  # API to calculate EMI for a specific feature
  def emi

    feature = Feature.find(params[:id])
    principal = feature.price.to_f # Using feature price as the principal amount
    interest_rate = params[:interest_rate].to_f / 100 / 12 # Monthly interest rate

    # Convert tenure into months if it's in years (default it to years if value is < 50)
    tenure = params[:tenure].to_i
    if tenure <= 50
      tenure = tenure * 12  # Assume the input is in years, convert it to months
    end

    # EMI Calculation: P * r * (1 + r)^n / [(1 + r)^n - 1]
    emi = (principal * interest_rate * ((1 + interest_rate) ** tenure)) / (((1 + interest_rate) ** tenure) - 1)

    render json: {
      feature_id: feature.id,
      variant_name: feature.variant_name,
      principal: principal,
      interest_rate: params[:interest_rate],
      tenure_in_months: tenure,
      emi: emi.round(2), # Rounded EMI value
      total_amount: (emi * tenure).to_i
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
    params.require(:feature).permit(:variant_name, :price, :colour, :city_mileage, :fuel_type, 
                                    :engine_displacement, :no_of_cylinders, :max_power, :max_torque, 
                                    :seating_capacity, :transmission_type, :boot_space, :fuel_tank_capacity, 
                                    :body_type, :ground_clearance_unladen, :power_steering, :abs, 
                                    :air_conditioner, :driver_airbag, :passenger_airbag, 
                                    :automatic_climate_control, :alloy_wheels, :multi_function_steering_wheel, 
                                    :engine_start_stop_button)
  end
end
