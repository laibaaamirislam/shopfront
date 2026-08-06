
class CheckoutsController < ApplicationController
  before_action :require_login

  def new
    @cart_items = current_cart.cart_items.includes(:product)
    redirect_to cart_path, alert: "Your cart is empty." if @cart_items.empty?
  end

  def create
    cart_items = current_cart.cart_items.includes(:product)

    if cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty." and return
    end

    order = nil

    ActiveRecord::Base.transaction do
      order = current_user.orders.create!(total_price: 0)

      cart_items.each do |item|
        if item.product.stock_quantity < item.quantity
          raise ActiveRecord::Rollback, "Not enough stock for #{item.product.name}"
        end

        order.line_items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )

        item.product.update!(stock_quantity: item.product.stock_quantity - item.quantity)
      end

      order.update!(total_price: order.line_items.sum { |li| li.price * li.quantity })
      current_cart.cart_items.destroy_all
    end

    if order&.persisted? && order.line_items.any?
      flash[:notice] = "Order placed successfully!"
      redirect_to order_path(order)
    else
      flash[:alert] = "Checkout failed — one or more items are out of stock."
      redirect_to cart_path
    end
  end
end