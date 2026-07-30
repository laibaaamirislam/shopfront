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

end