class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :update, :destroy, :login]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)

    # Validate user fields based on role
    if @user.role == 'customer' && has_dealer_fields?
      render json: { errors: 'Customers should not include address, brand, mobile number, or city.' }, status: :unprocessable_entity
      return
    end

    if @user.role == 'dealer' && missing_dealer_attributes?
      render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
      return
    end

    if @user.save
      render json: { message: 'User created', data: UserSerializer.new(@user) }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    # Validate user fields based on role
    if user_params[:role] == 'customer' && has_dealer_fields?
      render json: { errors: 'Customers should not include address, brand, mobile number, or city.' }, status: :unprocessable_entity
      return
    end

    if user_params[:role] == 'dealer' && missing_dealer_attributes?
      render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
      return
    end

    if @user.update(user_params)
      render json: { message: 'User updated', data: UserSerializer.new(@user) }, status: :ok
    else
      Rails.logger.debug(@user.errors.full_messages) # Debugging line
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def dealer_cars
    if current_user.role == 'dealer'
      if params[:dealer_id]
        # Fetch specified dealer's cars
        other_dealer = User.find_by(id: params[:dealer_id], role: 'dealer')
        if other_dealer
          cars = other_dealer.cars.includes(variants: :feature)
          render json: cars, each_serializer: CarSerializer, status: :ok
        else
          render json: { error: 'Dealer not found' }, status: :not_found
        end
      else
        # Fetch current user's cars
        cars = current_user.cars.includes(variants: :feature)
        render json: cars, each_serializer: CarSerializer, status: :ok
      end
    elsif current_user.role == 'customer'
      # Fetch the associated dealer's cars
      dealer_cars = current_user.dealer.cars.includes(variants: :feature)
      render json: dealer_cars, each_serializer: CarSerializer, status: :ok
    else
      render json: { error: 'Not authorized to view this information' }, status: :unauthorized
    end
  end

  def dealer_bookings
    if current_user.role == 'dealer'
      # Fetch all variants associated with the dealer's cars
      dealer_variants = Variant.joins(:car).where(cars: { user_id: current_user.id })

      # Get bookings for those variants
      bookings = Booking.includes(:variant).where(variant: dealer_variants).order(created_at: :desc)

      render json: bookings, include: [:variant], status: :ok
    else
      render json: { error: 'Not authorized to view this information' }, status: :unauthorized
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: 'User deleted' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      UserMailer.login_notification(user).deliver_now
      render json: { token: token, message: 'Login successfully' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    # If the user is a customer, exclude dealer-specific attributes
    permitted = [:name, :email, :password, :role]
    if params[:user][:role] == 'dealer'
      permitted += [:address, :brand, :mobile_number, :city]
    end
    params.require(:user).permit(permitted)
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end

  # Check if dealer-specific fields are missing
  def missing_dealer_attributes?
    required_fields = %w[address brand mobile_number city]
    required_fields.any? { |field| params[:user][field].blank? }
  end

  # Check if dealer-specific fields are present when not needed
  def has_dealer_fields?
    params[:user][:address].present? || params[:user][:brand].present? || params[:user][:mobile_number].present? || params[:user][:city].present?
  end
end





# class UsersController < ApplicationController
#   skip_before_action :authorize_request, only: [:create, :update, :destroy, :login]

#   def index
#     @users = User.all
#     render json: @users
#   end

#   def create
#     @user = User.new(user_params)
    
#     # If the role is 'customer', ensure no dealer-specific fields are provided
#     if @user.role == 'customer' && has_dealer_fields?
#       render json: { errors: 'Customers should not include address, brand, mobile number, or city.' }, status: :unprocessable_entity
#       return
#     end
    
#     # Apply additional validation if the role is 'dealer'
#     if @user.role == 'dealer' && missing_dealer_attributes?
#       render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
#       return
#     end

#     if @user.save
#       # Use the UserSerializer to format the response data
#       render json: { message: 'User created', data: UserSerializer.new(@user) }, status: :created
#     else
#       render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   def update
#     @user = User.find(params[:id])
    
#     # If the role is 'customer', ensure no dealer-specific fields are provided
#     if user_params[:role] == 'customer' && has_dealer_fields?
#       render json: { errors: 'Customers should not include address, brand, mobile number, or city.' }, status: :unprocessable_entity
#       return
#     end

#     # Apply additional validation if the role is 'dealer'
#     if user_params[:role] == 'dealer' && missing_dealer_attributes?
#       render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
#       return
#     end

#     if @user.update(user_params)
#       render json: { message: 'User updated', data: UserSerializer.new(@user) }, status: :ok
#     else
#       Rails.logger.debug(@user.errors.full_messages) # Debugging line
#       render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
#     end
#   rescue ActiveRecord::RecordNotFound
#     render json: { error: 'User not found' }, status: :not_found
#   end

# def dealer_cars
#   if current_user.role == 'dealer'
#     if params[:dealer_id]  # Checking if the dealer_id is provided
#       # Fetch the specified dealer's cars
#       other_dealer = User.find_by(id: params[:dealer_id], role: 'dealer')
#       if other_dealer
#         cars = other_dealer.cars.includes(variants: :feature)

#         # Render the cars using the CarSerializer
#         render json: cars, each_serializer: CarSerializer, status: :ok
#       else
#         render json: { error: 'Dealer not found' }, status: :not_found
#       end
#     else
#       # Fetch current user's cars
#       cars = current_user.cars.includes(variants: :feature)

#       # Render the cars using the CarSerializer
#       render json: cars, each_serializer: CarSerializer, status: :ok
#     end
#   elsif current_user.role == 'customer'
#     # If the current user is a customer, fetch the associated dealer's cars
#     dealer_cars = current_user.dealer.cars.includes(variants: :feature)

#     # Render the dealer's cars using the CarSerializer
#     render json: dealer_cars, each_serializer: CarSerializer, status: :ok
#   else
#     render json: { error: 'Not authorized to view this information' }, status: :unauthorized
#   end
# end



# def dealer_bookings
#   if current_user.role == 'dealer'
#     # Fetch all variants associated with the dealer's cars
#     dealer_variants = Variant.joins(:car).where(cars: { user_id: current_user.id })

#     # Get bookings for those variants
#     bookings = Booking.includes(:variant).where(variant: dealer_variants).order(created_at: :desc)

#     render json: bookings, include: [:variant], status: :ok
#   else
#     render json: { error: 'Not authorized to view this information' }, status: :unauthorized
#   end
# end



#   def destroy
#     @user = User.find(params[:id])
#     @user.destroy
#     render json: { message: 'User deleted' }, status: :ok
#   rescue ActiveRecord::RecordNotFound
#     render json: { error: 'User not found' }, status: :not_found
#   end

#   def login
#     user = User.find_by(email: params[:email])






#     if user && user.authenticate(params[:password])
#       token = encode_token({ user_id: user.id })
#       UserMailer.login_notification(user).deliver_now
#       render json: { token: token, message: 'Login successfully' }, status: :ok
#     else
#       render json: { error: 'Invalid email or password' }, status: :unauthorized
#     end
#   end

#   private

#   def user_params
#     # If the user is a customer, exclude dealer-specific attributes
#     permitted = [:name, :email, :password, :role]
#     if params[:user][:role] == 'dealer'
#       permitted += [:address, :brand, :mobile_number, :city]
#     end
#     params.require(:user).permit(permitted)
#   end

#   def encode_token(payload)
#     JWT.encode(payload, ENV['JWT_SECRET_KEY'])
#   end

#   # Check if dealer-specific fields are missing
#   def missing_dealer_attributes?
#     required_fields = %w[address brand mobile_number city]
#     required_fields.any? { |field| params[:user][field].blank? }
#   end

#   # Check if dealer-specific fields are present when not needed
#   def has_dealer_fields?
#     params[:user][:address].present? || params[:user][:brand].present? || params[:user][:mobile_number].present? || params[:user][:city].present?
#   end
# end





# # class UsersController < ApplicationController
# #   skip_before_action :authorize_request, only: [:create, :update, :destroy, :login]

# #   def index
# #     @user = User.all
# #     render json: @user
# #   end

# #   def create
# #     @user = User.new(user_params)
    
# #     # If the role is 'customer', ensure no dealer-specific fields are provided
# #     if @user.role == 'customer' && has_dealer_fields?
# #       render json: { errors: 'Customers should not include address, brand, mobile number, or city.' }, status: :unprocessable_entity
# #       return
# #     end
    
# #     # Apply additional validation if the role is 'dealer'
# #     if @user.role == 'dealer' && missing_dealer_attributes?
# #       render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
# #       return
# #     end

# #     if @user.save
# #       render json: { message: 'User created', data: @user }, status: :created
# #     else
# #       render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
# #     end
# #   end

# #   def update
# #     @user = User.find(params[:id])
    
# #     # If the role is 'customer', ensure no dealer-specific fields are provided
# #     if user_params[:role] == 'customer' && has_dealer_fields?
# #       render json: { errors: 'Customers should not include address, brand, mobile number, or city.' }, status: :unprocessable_entity
# #       return
# #     end

# #     # Apply additional validation if the role is 'dealer'
# #     if user_params[:role] == 'dealer' && missing_dealer_attributes?
# #       render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
# #       return
# #     end

# #     if @user.update(user_params)
# #       render json: { message: 'User updated', data: @user }, status: :ok
# #     else
# #       Rails.logger.debug(@user.errors.full_messages) # Debugging line
# #       render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
# #     end
# #   rescue ActiveRecord::RecordNotFound
# #     render json: { error: 'User not found' }, status: :not_found
# #   end

# #   def destroy
# #     @user = User.find(params[:id])
# #     @user.destroy
# #     render json: { message: 'User deleted' }, status: :ok
# #   rescue ActiveRecord::RecordNotFound
# #     render json: { error: 'User not found' }, status: :not_found
# #   end

# #   def login
# #     user = User.find_by(email: params[:email])

# #     if user && user.authenticate(params[:password])
# #       token = encode_token({ user_id: user.id })
# #       UserMailer.login_notification(user).deliver_now
# #       render json: { token: token, message: 'Login successfully' }, status: :ok
# #     else
# #       render json: { error: 'Invalid email or password' }, status: :unauthorized
# #     end
# #   end

# #   private

# #   def user_params
# #     # If the user is a customer, exclude dealer-specific attributes
# #     permitted = [:name, :email, :password, :role]
# #     if params[:user][:role] == 'dealer'
# #       permitted += [:address, :brand, :mobile_number, :city]
# #     end
# #     params.require(:user).permit(permitted)
# #   end

# #   def encode_token(payload)
# #     JWT.encode(payload, ENV['JWT_SECRET_KEY'])
# #   end

# #   # Check if dealer-specific fields are missing
# #   def missing_dealer_attributes?
# #     required_fields = %w[address brand mobile_number city]
# #     required_fields.any? { |field| params[:user][field].blank? }
# #   end

# #   # Check if dealer-specific fields are present when not needed
# #   def has_dealer_fields?
# #     params[:user][:address].present? || params[:user][:brand].present? || params[:user][:mobile_number].present? || params[:user][:city].present?
# #   end
# # end




# # # class UsersController < ApplicationController

# # #   skip_before_action :authorize_request, only: [:create, :update, :destroy, :login]

# # #   def index
# # #     @user = User.all
# # #     render json: @current_user
# # #   end

# # #   def create
# # #     @user = User.new(user_params)
    
# # #     # Apply additional validation if the role is 'dealer'
# # #     if @user.role == 'dealer' && missing_dealer_attributes?
# # #       render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
# # #       return
# # #     end

# # #     if @user.save
# # #       render json: { message: 'User created', data: @user }, status: :created
# # #     else
# # #       render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
# # #     end
# # #   end

# # #   def update
# # #     @user = User.find(params[:id])
    
# # #     # Apply additional validation if the role is 'dealer'
# # #     if user_params[:role] == 'dealer' && missing_dealer_attributes?
# # #       render json: { errors: 'Dealers must provide address, brand, mobile number, and city.' }, status: :unprocessable_entity
# # #       return
# # #     end

# # #     if @user.update(user_params)
# # #       render json: { message: 'User updated', data: @user }, status: :ok
# # #     else
# # #       Rails.logger.debug(@user.errors.full_messages) # Debugging line
# # #       render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
# # #     end
# # #   rescue ActiveRecord::RecordNotFound
# # #     render json: { error: 'User not found' }, status: :not_found
# # #   end

# # #   def destroy
# # #     @user = User.find(params[:id])
# # #     @user.destroy
# # #     render json: { message: 'User deleted' }, status: :ok
# # #   rescue ActiveRecord::RecordNotFound
# # #     render json: { error: 'User not found' }, status: :not_found
# # #   end

# # #   def login
# # #     user = User.find_by(email: params[:email])

# # #     if user && user.authenticate(params[:password])
# # #       token = encode_token({ user_id: user.id })
# # #       UserMailer.login_notification(user).deliver_now
# # #       render json: { token: token, message: 'Login successfully' }, status: :ok
# # #     else
# # #       render json: { error: 'Invalid email or password' }, status: :unauthorized
# # #     end
# # #   end

# # #   private

# # #   def user_params
# # #     # If the user is a customer, exclude dealer-specific attributes
# # #     permitted = [:name, :email, :password, :role]
# # #     if params[:user][:role] == 'dealer'
# # #       permitted += [:address, :brand, :mobile_number, :city]
# # #     end
# # #     params.require(:user).permit(permitted)
# # #   end


# # #   def encode_token(payload)
# # #     JWT.encode(payload, ENV['JWT_SECRET_KEY'])
# # #   end

# # #   # Check if dealer-specific fields are missing
# # #   def missing_dealer_attributes?
# # #     required_fields = %w[address brand mobile_number city]
# # #     required_fields.any? { |field| params[:user][field].blank? }
# # #   end
# # # end
