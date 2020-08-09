module V1
  class SessionsController < ApplicationController
    def create
      email, password = WebToken.basic_decode(basic_token)
      @user = User.find_by_email(email)

      if @user&.authenticate(password)
        render :create, status: :created
      else
        render json: { error: 'invalid' }, status: :unauthorized
      end
    end
  end
end
