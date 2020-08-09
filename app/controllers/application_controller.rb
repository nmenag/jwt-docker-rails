class ApplicationController < ActionController::API
  def basic_token
    request.headers['Authorization']&.gsub("\n", '')&.split(' ')&.last
  end
end
