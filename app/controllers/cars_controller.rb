class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy, :add_feature]

  # GET /cars
  # def index
  #   @cars = Car.all

  #   # Filtering by price range
  #   if params[:min_price].present? && params[:max_price].present?
  #     @cars = @cars.by_price_range(params[:min_price], params[:max_price])
  #   end

  #   # Filtering by body type
  #   if params[:body_type].present?
  #     @cars = @cars.by_body_type(params[:body_type])
  #   end

  #   # Filtering by fuel type
  #   if params[:fuel_type].present?
  #     @cars = @cars.by_fuel_type(params[:fuel_type])
  #   end

  #   # Filtering by car type (new or upcoming)
  #   case params[:car_type]
  #   when 'new'
  #     @cars = @cars.new_cars
  #   when 'upcoming'
  #     @cars = @cars.upcoming_cars
  #   end

  #   # Pagination (assuming you're using Kaminari or WillPaginate)
  #   @cars = @cars.page(params[:page]).per(10) # Customize items per page as needed

  #   render json: @cars, status: :ok
  # end


  def index
    @cars = Car.includes(:features) # Eager load features to avoid N+1 query
  
    # Filtering by price range
    if params[:min_price].present? && params[:max_price].present?
      @cars = @cars.by_price_range(params[:min_price], params[:max_price])
    end
  
    # Filtering by body type
    if params[:body_type].present?
      @cars = @cars.by_body_type(params[:body_type])
    end
  
    # Filtering by fuel type
    if params[:fuel_type].present?
      @cars = @cars.by_fuel_type(params[:fuel_type])
    end
  
    # Filtering by car type (new or upcoming)
    case params[:car_type]
    when 'new'
      @cars = @cars.new_cars
    when 'upcoming'
      @cars = @cars.upcoming_cars
    end
  
    # Pagination (assuming you're using Kaminari or WillPaginate)
    @cars = @cars.page(params[:page]).per(10) # Customize items per page as needed
  
    # Render JSON with car details including features
    render json: @cars.as_json(include: :features), status: :ok
  end
  

  # GET /cars/:id
  def show
    render json: @car, status: :ok
  end

  # POST /cars
  def create
    # debugger
    @car = Car.new(car_params)
    if @car.save
      render json: { car: @car, notice: 'Car was successfully created.' }, status: :created
    else
      render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cars/:id
  def update
    if @car.update(car_params)
      render json: { car: @car, notice: 'Car was successfully updated.' }, status: :ok
    else
      render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /cars/:id
  def destroy
    @car.destroy
    render json: { notice: 'Car was successfully destroyed.' }, status: :ok
  end

  # POST /cars/:id/add_feature
  def add_feature
    feature = Feature.find(params[:feature_id])

    if @car.features.exists?(feature.id)
      render json: { error: 'Feature is already associated with this car.' }, status: :unprocessable_entity
    else
      @car.features << feature
      render json: { features: @car.features, notice: 'Feature successfully added.' }, status: :ok
    end
  end

  private

  # Find the car by ID, handle not found errors
  def set_car
    @car = Car.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Car not found' }, status: :not_found
  end

  # Strong parameters to allow only trusted data
  def car_params
    def car_params
      params.require(:car).permit(:name, :brand_id, :body_type, :car_types, :launch_date, features_attributes: [
        :id, :variant_name, :price, :colour, :city_mileage, :fuel_type, :engine_displacement, :no_of_cylinders, 
        :max_power, :max_torque, :seating_capacity, :transmission_type, :boot_space, 
        :fuel_tank_capacity, :body_type, :power_steering, 
        :abs, :air_conditioner, :driver_airbag, :passenger_airbag, 
        :automatic_climate_control, :alloy_wheels, :multi_function_steering_wheel, 
        :engine_start_stop_button
      ])
    end
    
  end
end
