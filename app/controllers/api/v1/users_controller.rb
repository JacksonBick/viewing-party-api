class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  def index
    users = User.all
    render json: UserSerializer.new(users).serializable_hash
  end

  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user).serializable_hash
  end
  
  private

  def user_params
    params.permit(:name, :username, :password, :password_confirmation)
  end
end