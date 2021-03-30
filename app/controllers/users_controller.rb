class UsersController < ApplicationController
  def index 
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  def create
    @user = User.create(create_params)
    render json: @user, status: :created
  end

  def update 
    @user = User.find(params['id'])
    @user.update(update_params)
    render json: @user, status: :ok
  end

  private
  def create_params 
    params.require(:user).permit(:email, :password, :total_budget)
  end

  def update_params 
    params.require(:user).permit(:email, :password, :total_budget)
  end
end