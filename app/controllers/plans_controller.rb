class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :update, :destroy]
  def index
  # Use pagy for pagination
  pagy, plans = pagy(Plan.all, items: 10)

  render json: {
    plans: ActiveModelSerializers::SerializableResource.new(plans, each_serializer: PlanSerializer),
    meta: pagination_metadata(pagy)
  }
end


  # GET /plans/:id
  def show
    render json: @plan, serializer: PlanSerializer, status: :ok
  end

  # POST /plans
  def create
    plan = Plan.new(plan_params)
    if plan.save
      render json: { plan: PlanSerializer.new(plan), message: 'Plan successfully created.' }, status: :created
    else
      render json: { errors: plan.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /plans/:id
  def update
    if @plan.update(plan_params)
      render json: { plan: PlanSerializer.new(@plan), message: 'Plan successfully updated.' }, status: :ok
    else
      render json: { errors: @plan.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /plans/:id
  def destroy
    @plan.destroy
    render json: { message: 'Plan successfully deleted.' }, status: :ok
  end




  private

  # Set plan for show, update, and destroy actions
  def set_plan
    @plan = Plan.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Plan not found' }, status: :not_found
  end

  # Strong parameters for Plan
  def plan_params
    params.require(:plan).permit(:name, :price, :details, :plan_type, :months, 
                                 :price_monthly, :price_yearly, :limit, :limit_type, 
                                 :discount, :discount_type, :discount_percentage, 
                                 :benefits, :coming_soon, :active, :available)
  end
end
