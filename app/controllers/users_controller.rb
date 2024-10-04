class UsersController < ApplicationController

skip_before_action :authorize_request, only: [:create, :login]


def index
  @user = User.all
  render json:@user
  
end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
  
      render json: { message: 'user created', data:@user }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
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