# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      if session[:cart_id] && (guest_cart = Cart.find_by(id: session[:cart_id]))
        if user.cart.nil? && guest_cart.cart_items.any?
          guest_cart.update(user: user)
        end
        session.delete(:cart_id)
      end

      if user.admin?
        redirect_to admin_root_path, notice: "Signed in as Administrator."
      else
        redirect_to products_path, notice: "Logged in successfully."
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:cart_id) # Wipes the cart session on logout
    flash[:notice] = "Logged out."
    redirect_to root_path
  end
end