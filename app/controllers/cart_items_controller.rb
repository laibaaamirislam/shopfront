class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    item = current_cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = (item.quantity || 0) + 1
    item.save

    flash[:notice] = "Added #{product.name} to your cart."
    redirect_back fallback_location: product_path(product)
  end

  def update
    item = current_cart.cart_items.find(params[:id])
    item.update(quantity: params[:quantity])
    redirect_to cart_path
  end

  def destroy
    item = current_cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path
  end
end