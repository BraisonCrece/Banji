class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]
  skip_before_action :protect_pages, only: [:index, :show]
  
  def index
    @categories = Category.order(:name).load_async
    @pagy, @products = pagy_countless(FindProducts.new.call(product_filter_params).load_async, items: 12)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.includes(:user).find(params[:id])
  end

  def edit
    authorize! @product
  end

  def update
    authorize! @product
    if @product.update(product_params)
      redirect_to root_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @product
    if @product.destroy!
      redirect_to root_path, alert: t('.deleted'), status: :see_other
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, images: [])
  end

  def product_filter_params
    params.permit(:min_price, :max_price, :query_text, :order_by, :category_id, :page, :favorite, :user_id)
  end

  def set_product
    @product ||= Product.find(params[:id])
  end
  
end
