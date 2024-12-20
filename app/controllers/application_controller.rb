class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  include Pagy::Backend

  private 

  def pagination_metadata(pagy)
    {
      current_page: pagy.page,
      total_pages: pagy.pages,
      total_count: pagy.count
    }
  end


  def authorize_request
    return if request.path.start_with?('/admin')
    header = request.headers['Token']
    token = header.split(' ').last if header

    if token
      decoded = decode_token(token)
      if decoded
        @current_user = User.find_by(id: decoded['user_id'])
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token not provided' }, status: :unauthorized
    end
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized request' }, status: :unauthorized
  end

  def decode_token(token)
    JWT.decode(token, ENV['JWT_SECRET_KEY'], true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end


def current_user
  @current_user
end




end