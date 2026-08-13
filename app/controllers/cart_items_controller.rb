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
    if item.update(cart_item_params)
      redirect_to cart_path, notice: "Cart updated."
    else
      redirect_to cart_path, alert: @cart_item.errors.full_messages.to_sentence
    end
  end

  def destroy
    item = current_cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end