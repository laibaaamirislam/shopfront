
class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Shopfront!"
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(account_params)
      flash[:notice] = "Account updated."
      redirect_to account_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end