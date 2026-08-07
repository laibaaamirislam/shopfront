
class ApplicationController < ActionController::Base
  helper_method :current_user, :current_cart

  private

  def require_login
    unless current_user
      session[:return_to] = request.fullpath
      flash[:alert] = "Please log in to continue."
      redirect_to login_path
    end
  end

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

  private

  def require_admin
    # Ensure user is logged in first if you have a current_user helper
    unless current_user&.role == "admin" # or current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end