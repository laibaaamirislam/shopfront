
class OrdersController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:admin_index, :update_status]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.admin? ? Order.find(params[:id]) : current_user.orders.find(params[:id])
  end

  def admin_index
    @orders = Order.includes(:user).order(created_at: :desc)
  end

  def update_status
    order = Order.find(params[:id])
    order.update(status: params[:status])
    redirect_to admin_orders_path, notice: "Order ##{order.id} marked as #{order.status}."
  end

  def confirmation
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    # ...unchanged from the payment guide, whenever you resume that...
  end
end