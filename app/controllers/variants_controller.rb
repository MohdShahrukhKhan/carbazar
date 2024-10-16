# class VariantsController < ApplicationController
#     before_action :set_variant, only: [:update, :destroy, :emi]

#   def index
#     pagy, variants = pagy(Variant.all, items: 20)
#     render json: {
#       variants: ActiveModelSerializers::SerializableResource.new(variants, each_serializer: VariantSerializer),
#       meta: pagination_metadata(pagy)
#     }
#   end

#   def show
#     variant = Variant.find(params[:id])
#     render json: variant
#   end

#   def create
#     @variant = Variant.new(variant_params)

#     if @variant.save
#       render json: @variant, status: :created
#     else
#       render json: @variant.errors, status: :unprocessable_entity
#     end
#   end

#   def update
#     variant = Variant.find(params[:id])
#     if variant.update(variant_params)
#       render json: variant
#     else
#       render json: variant.errors, status: :unprocessable_entity
#     end
#   end

#   def destroy
#     variant = Variant.find(params[:id])
#     variant.destroy
#     head :no_content
#   end

#   def emi
#     variant = Variant.find(params[:id])

#     principal = variant.price.to_f
#     interest_rate = params[:interest_rate].to_f / 100 / 12
#     tenure = params[:tenure].to_i
#     if tenure <= 50
#       tenure = tenure * 12  # Assume the input is in years, convert it to months
#     end

#     emi = (principal * interest_rate * (1 + interest_rate)**tenure) / ((1 + interest_rate)**tenure - 1)
#     total_amount = (emi * tenure).to_i

#     render json: {
#       variant_id: variant.id,
#       variant_name: variant.variant,  # Adjust based on your attribute name
#       principal: principal,
#       interest_rate: params[:interest_rate],
#       tenure_in_months: tenure,
#       emi: emi.round(2),  # Rounded EMI value
#       total_amount: total_amount
#     }, status: :ok
#   end

#   private

#   def variant_params
#     params.require(:variant).permit(:variant, :price, :colour, :car_id, :quantity)
#   end
# end





class VariantsController < ApplicationController
  before_action :set_variant, only: [:show, :update, :destroy, :emi]

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











  private

  def set_variant
    @variant = Variant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Variant not found" }, status: :not_found
  end

  def variant_params
    params.require(:variant).permit(:variant, :price, :colour, :car_id, :quantity)
  end
end
