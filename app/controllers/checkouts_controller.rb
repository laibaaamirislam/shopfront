# app/controllers/checkouts_controller.rb (new)
class CheckoutsController < ApplicationController
  before_action :require_login

  def new
    @cart_items = current_cart.cart_items.includes(:product)
    redirect_to cart_path, alert: "Your cart is empty." if @cart_items.empty?
  end
end