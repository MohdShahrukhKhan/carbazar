class VariantsController < ApplicationController
  before_action :set_variant, only: [:show, :update, :destroy, :emi]
  before_action :authorize_dealer, only: [:create, :update, :destroy]

  def index
    pagy, variants = pagy(Variant.all, items: 20)
    render json: {
      variants: ActiveModelSerializers::SerializableResource.new(variants, each_serializer: VariantSerializer),
      meta: pagination_metadata(pagy)
    }
  end

  def show
    render json: @variant
  end

  def create
    @variant = Variant.new(variant_params)

    if @variant.save
      render json: @variant, status: :created
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  def update
    if @variant.update(variant_params)
      render json: @variant
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @variant.destroy
    head :no_content
  end

  def emi
    variant = @variant

    principal = variant.price.to_f
    interest_rate = params[:interest_rate].to_f / 100 / 12
    tenure = params[:tenure].to_i

    # Validate inputs
    if principal <= 0 || interest_rate <= 0 || tenure <= 0
      render json: { error: "Invalid input values" }, status: :unprocessable_entity and return
    end

    # If tenure <= 50, assume it is in years and convert to months
    tenure = tenure * 12 if tenure <= 50

    begin
      # EMI formula
      emi = (principal * interest_rate * (1 + interest_rate)**tenure) / ((1 + interest_rate)**tenure - 1)
      total_amount = (emi * tenure).to_i

      render json: {
        variant_id: variant.id,
        variant_name: variant.variant,  # Adjust according to your attribute names
        principal: principal,
        interest_rate: params[:interest_rate],
        tenure_in_months: tenure,
        emi: emi.round(2),
        total_amount: total_amount
      }, status: :ok

    rescue StandardError => e
      render json: { error: "EMI calculation failed: #{e.message}" }, status: :unprocessable_entity
    end
  end
  

     def popular
    popular_variants = Variant.most_purchased
    pagy, paginated_variants = pagy(popular_variants, items: 10)

    render json: {
      variants: ActiveModelSerializers::SerializableResource.new(paginated_variants, each_serializer: VariantSerializer),
      meta: pagination_metadata(pagy)
    }, status: :ok
  end

  private

  def set_variant
    @variant = Variant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Variant not found" }, status: :not_found
  end

  def authorize_dealer
    unless current_user&.role == 'dealer'
      render json: { error: "You are not authorized to perform this action" }, status: :forbidden
    end
  end

  def variant_params
    params.require(:variant).permit(
      :variant, :price, :colour, :car_id, :quantity,
      feature_attributes: [
        :id, :city_mileage, :fuel_type, :engine_displacement, :no_of_cylinders,
        :max_power, :max_torque, :seating_capacity, :transmission_type, :boot_space,
        :fuel_tank_capacity, :body_type, :ground_clearance_unladen, :power_steering,
        :abs, :air_conditioner, :driver_airbag, :passenger_airbag, :automatic_climate_control,
        :alloy_wheels, :multi_function_steering_wheel, :engine_start_stop_button, :_destroy
      ]
    )
  end
end
