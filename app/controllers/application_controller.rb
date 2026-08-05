
class ApplicationController < ActionController::Base
  helper_method :current_user, :current_cart

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id]) || create_cart
  end

  def create_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def require_login
    unless current_user
      flash[:alert] = "Please log in to continue."
      redirect_to login_path
    end
  end
end