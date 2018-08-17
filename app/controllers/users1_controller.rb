# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'Register success'
      redirect_to users_path
    else
      flash[:success] = 'Register failed'
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end

  def edit
    @user = User.find_by id: session[:user_id]
  end

  def update
    @user = User.find(params[:id])
    if @user.update(product_params)
      flash[:success] = 'Update success'
      redirect_to users_update_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :address, :user_name, :password, :password_confirmation
  end
end
