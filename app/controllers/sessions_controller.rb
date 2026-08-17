
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      if session[:cart_id] && (guest_cart = Cart.find_by(id: session[:cart_id]))
        user_cart = user.cart || user.create_cart

        guest_cart.cart_items.each do |item|
          existing_item = user_cart.cart_items.find_by(product_id: item.product_id)
          if existing_item
            existing_item.update(quantity: existing_item.quantity + item.quantity)
          else
            item.update(cart: user_cart)
          end
        end

        # Destroy the temporary guest cart & clear session
        guest_cart.destroy
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
    session.delete(:cart_id)
    flash[:notice] = "Logged out."
    redirect_to root_path
  end
end