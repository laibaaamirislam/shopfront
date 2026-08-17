# app/controllers/products_controller.rb
class ProductsController < ApplicationController

    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def show
    @related_products = @product.category.products
        .where.not(id: @product.id).limit(3)
    end

    def index
        @products = Product.search(params[:query]).in_category(params[:category_id])
                     .paginate(page: params[:page], per_page: 6)

        @categories = Category.all
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

    def edit
        
    end

    def update
        

        if @product.update(product_params)
            flash[:notice] = "Product was updated successfully."
            redirect_to product_path(@product)
        else
            render 'edit'
        end
    end

    def destroy
        
        @product.destroy
        flash[:notice] = "Product was removed from the catalog."
        redirect_to products_path
    end

    private

    def product_params
        params.require(:product).permit(:name, :description, :price, :stock_quantity, :sku, :category_id, :image)
    end

    def set_product
        @product = Product.find(params[:id])
    end

    def require_admin
        unless logged_in? && current_user.admin?
        flash[:alert] = "Only admins can perform that action."
        redirect_to categories_path
        end
    end

end