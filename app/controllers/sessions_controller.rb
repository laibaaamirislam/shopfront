class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out."
    redirect_to root_path
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_path = session.delete(:return_to) || root_path
      flash[:notice] = "Logged in successfully."
      redirect_to redirect_path
    else
      flash.now[:alert] = "Invalid email or password."
      render "new"
    end
  end

end