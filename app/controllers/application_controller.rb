class ApplicationController < ActionController::API
  def basic_token
    request.headers['Authorization']&.gsub("\n", '')&.split(' ')&.last
  end

  def current_user
    @current_user ||= User.find_by(auth_token: payload[0]['token'])
  end


  def authenticate_user!
    render json: {error: 'not authenticated' },
           status: :unauthorized unless current_user.present?
  end

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    WebToken.decode(token)
  end
end
