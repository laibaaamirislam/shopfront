# app/controllers/products_controller.rb
class ProductsController < ApplicationController

    def show
        @product = Product.find(params[:id])
    end

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

            if @product.save
                flash[:notice] = "Product was added successfully."
                redirect_to product_path(@product)
            else
                render 'new'
            end
        end

        private

        def product_params
            params.require(:product).permit(:name, :description, :price, :stock_quantity, :sku)
        end
end