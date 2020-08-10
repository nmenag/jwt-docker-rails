module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!
    before_action :verify_user, except: %i[index create]

    def index
      @users = User.where.not(id: current_user.id)
    end

    def create
      @user = User.new(user_params)

      if @user.save!
        render :show, status: :created
      else
        render json: @user.errors.map { |x, mess| "#{x} #{mess}".capitalize },
               status: :unprocessable_entity

      end
    end

    def update
      @user.assign_attributes(user_params)

      if @user.save
        render :show, status: :accepted
      else
        render json: @user.errors.map { |x, mess| "#{x} #{mess}".capitalize },
               status: :unprocessable_entity

      end
    end

    def destroy
      @user.destroy!
      render json: { message: 'user was deleted' }, status: :accepted
    end

    private

    def user_params
      params.permit(:email, :name, :role, :active)
    end

    def verify_user
      @user = User.find_by(id: params[:id])

      return if @user.present?

      not_found_response
    end
  end
end