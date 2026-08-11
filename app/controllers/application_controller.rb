
class ApplicationController < ActionController::Base
  helper_method :current_user, :current_cart

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_cart
    if current_user
      @current_cart ||= current_user.cart || current_user.create_cart
    else
      # Guest user handling
      if session[:cart_id]
        @current_cart ||= Cart.find_by(id: session[:cart_id])
      end

      if @current_cart.nil?
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end

      @current_cart
    end
  end
end