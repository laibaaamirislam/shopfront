
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

    if order.update(status: params[:status])
      redirect_to admin_orders_path, notice: "Order ##{order.id} marked as #{order.status}."
    else
      redirect_to admin_orders_path, alert: "Couldn't update order ##{order.id}: #{order.errors.full_messages.to_sentence}"
    end
  end
end