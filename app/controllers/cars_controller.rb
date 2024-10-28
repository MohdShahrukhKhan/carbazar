class CarsController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy]
  before_action :authorize_dealer, only: [:create, :update]


def index
  @cars = Car.includes(variants: :feature) # Eager load variants and features

  # Filtering by car type (new or upcoming)
  case params[:car_type]
  when 'new'
    @cars = @cars.new_cars
  when 'upcoming'
    @cars = @cars.upcoming_cars
  end

  # Pagination using Pagy
  pagy, paginated_cars = pagy(@cars, items: 10)

  # Render JSON with cars and Pagy metadata
  render json: {
    cars: ActiveModelSerializers::SerializableResource.new(paginated_cars, each_serializer: CarSerializer),
    meta: pagination_metadata(pagy)
  }, status: :ok
end



  # GET /cars/:id
  def show
    # Track the viewed car in the session (limit to last 2 cars)
    session[:last_seen_cars] ||= []
    session[:last_seen_cars].delete(@car.id) # Remove the car if it's already in the list
    session[:last_seen_cars] << @car.id # Add it to the end
    session[:last_seen_cars] = session[:last_seen_cars].last(2) # Keep only the last 2 cars

    render json: @car, serializer: CarSerializer, status: :ok
  end

  # GET /cars/last_seen
  def last_seen
    if session[:last_seen_cars].present?
      last_seen_cars = Car.where(id: session[:last_seen_cars])
      render json: last_seen_cars, each_serializer: CarSerializer, status: :ok
    else
      render json: { message: 'No cars viewed recently' }, status: :ok
    end
  end

   def popular
    popular_cars = Car.popular
    pagy, paginated_cars = pagy(popular_cars, items: 10)

    render json: {
      cars: ActiveModelSerializers::SerializableResource.new(paginated_cars, each_serializer: CarSerializer),
      meta: pagination_metadata(pagy)
    }, status: :ok
  end


def create
  # Check if the current user is a dealer
  if current_user.role == 'dealer'
    @car = current_user.cars.new(car_params)  # Associate the car with the current user (dealer)

    if @car.save
      render json: @car, serializer: CarSerializer, status: :created
    else
      render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
    end
  else
    render json: { error: 'Unauthorized: Only dealers can create cars.' }, status: :unauthorized
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

  private

  # Find the car by ID, handle not found errors
  def set_car
    @car = Car.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Car not found' }, status: :not_found
  end

  # Strong parameters to allow only trusted data
  def car_params
    params.require(:car).permit(
      :name, :brand_id, :body_type, :car_types, :launch_date,
      variants_attributes: [:id, :variant, :price, :colour, :car_id, :quantity]
    )
  end

  # Authorization to ensure only dealers can create or update cars
  def authorize_dealer
    unless current_user&.role == 'dealer'
      render json: { error: 'Unauthorized: Only dealers can create or update cars.' }, status: :unauthorized
    end
  end
end





# class CarsController < ApplicationController



#   before_action :set_car, only: [:show, :edit, :update, :destroy]

#   # GET /cars
#   def index
#     @cars = Car.all # Adjust this if you have specific filtering logic

#     # Filtering by car type (new or upcoming)
#     case params[:car_type]
#     when 'new'
#       @cars = @cars.new_cars
#     when 'upcoming'
#       @cars = @cars.upcoming_cars
#     end

#     # Pagination using Pagy
#     pagy, paginated_cars = pagy(@cars, items: 10)

#     # Render JSON with cars and Pagy metadata
#     render json: {
#       cars: ActiveModelSerializers::SerializableResource.new(paginated_cars, each_serializer: CarSerializer),
#       meta: pagination_metadata(pagy)
#     }, status: :ok
#   end

#   # GET /cars/:id
#   def show
#     # Track the viewed car in the session (limit to last 2 cars)
#     session[:last_seen_cars] ||= []
#     session[:last_seen_cars].delete(@car.id) # Remove the car if it's already in the list
#     session[:last_seen_cars] << @car.id # Add it to the end
#     session[:last_seen_cars] = session[:last_seen_cars].last(2) # Keep only the last 2 cars

#     render json: @car, serializer: CarSerializer, status: :ok
#   end

#   # GET /cars/last_seen
#   def last_seen
#     if session[:last_seen_cars].present?
#       last_seen_cars = Car.where(id: session[:last_seen_cars])
#       render json: last_seen_cars, each_serializer: CarSerializer, status: :ok
#     else
#       render json: { message: 'No cars viewed recently' }, status: :ok
#     end
#   end

    


#   # POST /cars
#   def create
#     @car = Car.new(car_params)
#     if @car.save
#       render json: { car: @car, notice: 'Car was successfully created.' }, status: :created
#     else
#       render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   # PATCH/PUT /cars/:id
#   def update
#     if @car.update(car_params)
#       render json: { car: @car, notice: 'Car was successfully updated.' }, status: :ok
#     else
#       render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   # DELETE /cars/:id
#   def destroy
#     @car.destroy
#     render json: { notice: 'Car was successfully destroyed.' }, status: :ok
#   end

#   private

#   # Find the car by ID, handle not found errors
#   def set_car
#     @car = Car.find(params[:id])
#   rescue ActiveRecord::RecordNotFound
#     render json: { error: 'Car not found' }, status: :not_found
#   end

#   # Strong parameters to allow only trusted data
#   def car_params
#     params.require(:car).permit(
#       :name, :brand_id, :body_type, :car_types, :launch_date,
#       variants_attributes: [:id, :variant, :price, :colour, :car_id, :quantity]
#     )
#   end
# end

