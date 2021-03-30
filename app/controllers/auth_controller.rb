require 'byebug'

class AuthController < ApplicationController
  def login
    @user = User.find_by email: params[:email], password: params[:password]
    render json: @user, status: :ok
  end

  def register
    @user = User.create(create_params)
    render json: @user, status: :created
  end

  private
  def create_params
    params.require(:user).permit(:email, :password, :total_budget).reverse_merge({total_budget: 0})
  end
end