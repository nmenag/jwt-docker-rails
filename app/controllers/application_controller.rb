class ApplicationController < ActionController::API
  def basic_token
    request.headers['Authorization']&.gsub("\n", '')&.split(' ')&.last
  end

  def current_user
    jwt_token = payload
    return  authorized_response if jwt_token == :invalid_credentials

    @current_user ||= User.find_by(auth_token: jwt_token[0]['token'])
  end

  def authenticate_user!
    authorized_response unless current_user.present?
  end

  def authorized_response
    render json: { error: 'not authenticated' },
           status: :unauthorized
  end

  def authorize!
    @current_user ||= current_user

    return if @current_user.admin?
  end

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    WebToken.decode(token)
  end
end
