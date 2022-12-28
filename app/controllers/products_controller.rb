class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order(:name).load_async
    @products = SearchService.sort(Product.with_attached_images.load_async, params)
    if  params[:category_id] || 
        params[:min_price].present? || 
        params[:max_price].present? || 
        params[:query_text].present? || 
        params[:order_by]
      @products = SearchService.search(@products, params)
    end
    @pagy, @products = pagy_countless(@products, items: 12)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy!
      redirect_to root_path, alert: t('.deleted'), status: :see_other
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
  
end
