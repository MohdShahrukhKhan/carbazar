class UsersController < ApplicationController

skip_before_action :authorize_request, only: [:create, :update,:destroy, :login]


def index
  @user = User.all
  render json:@current_user
  
end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
  
      render json: { message: 'user created', data:@user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end



  def update
  @user = User.find(params[:id])
  
  if @user.update(user_params)
    render json: { message: 'User updated', data: @user }, status: :ok
  else
     Rails.logger.debug(@user.errors.full_messages) # Debugging line
     render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end
rescue ActiveRecord::RecordNotFound
  render json: { error: 'User not found' }, status: :not_found
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

    if user && user.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      UserMailer.login_notification(user).deliver_now
      render json: { token: token,message: "login successfully" }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end


  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end




end