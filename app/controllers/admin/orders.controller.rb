# app/controllers/admin/orders_controller.rb
module Admin
  class OrdersController < BaseController
    def index
      @orders = Order.includes(:user).order(created_at: :desc)
    end

    def show
      @order = Order.find(params[:id])
    end

    def update
      order = Order.find(params[:id])
      if order.update(status: params[:status])
        redirect_to admin_orders_path, notice: "Order ##{order.id} marked as #{order.status}."
      else
        redirect_to admin_orders_path, alert: order.errors.full_messages.to_sentence
      end
    end
  end
end