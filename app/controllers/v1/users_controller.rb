module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
      @users = User.where.not(id: current_user.id)
      render :index, status: :ok
    end
  end
end