# app/controllers/admin/dashboard_controller.rb
module Admin
  class DashboardController < BaseController
    def index
      @total_revenue = Order.where(status: %w[paid shipped delivered]).sum(:total_price)
      @order_count = Order.count
      @low_stock_products = Product.where("stock_quantity <= ?", 5).order(:stock_quantity)
      @recent_orders = Order.includes(:user).order(created_at: :desc).limit(5)
    end
  end
end