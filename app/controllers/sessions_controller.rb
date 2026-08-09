class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      if user.admin?
        # Redirect admins to the admin dashboard
        redirect_to admin_root_path, notice: "Signed in as Administrator."
      else
        # Redirect customers straight to the Catalog
        redirect_to products_path, notice: "Logged in successfully."
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out."
    redirect_to root_path
  end

end