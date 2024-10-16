class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

def index
  @cars = Car.includes(:variants)


  # Filtering by body type
  if params[:body_type].present?
    @cars = @cars.by_body_type(params[:body_type])
  end

 
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



  def create
      catalogue = Car.new()
      save_result = catalogue.save

      if save_result
        process_images(catalogue, params[:images])

        catalogue.tags << Tag.where(id: params[:tags_id])

        process_variants_images(catalogue)

        render json: CatalogueSerializer.new(catalogue, serialization_options)
                         .serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(catalogue).serializable_hash,
               status: :unprocessable_entity
      end
    end

  # # GET /cars/:id
  # def show
  #   render json: @car, serializer: CarSerializer, status: :ok
  # end


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


  # POST /cars
  def create
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
      variants_attributes: [:id, :variant, :price, :colour, :car_id, :_destroy]
    )
  end
end







# class CarsController < ApplicationController
#   before_action :set_car, only: [:show, :edit, :update, :destroy, :add_feature]

# # GET /cars
# def index
#   @cars = Car.includes(:features)

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

#   # Pagination using Pagy
#   pagy, paginated_cars = pagy(@cars, items: 10) # Customize items per page if needed

#   # Render JSON with cars and Pagy metadata
#   render json: {
#     cars: ActiveModelSerializers::SerializableResource.new(paginated_cars, each_serializer: CarSerializer),
#     meta: pagination_metadata(pagy) # Pagy metadata for pagination
#   }, status: :ok
# end



#   # GET /cars/:id
#   def show
#     render json: @car, serializer: CarSerializer, status: :ok
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
#     params.require(:car).permit(:name, :brand_id, :body_type, :car_types, :launch_date)
#   end
# end
