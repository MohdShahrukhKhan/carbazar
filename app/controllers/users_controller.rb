class UsersController < ApplicationController

   
    def show
      render json: @current_user
    end

    def create
        @user = User.new(user_params)
    
        if @user.save
          #token = encode_token({ user_id: @user.id })  # Generate JWT token
          render json: { user: @user, message:"user created" }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end


      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    
#       def encode_token(payload)
#         JWT.encode(payload, 'your_secret_key')  # Replace with your secret key
#       end
# 
end