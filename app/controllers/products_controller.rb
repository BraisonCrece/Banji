class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.with_attached_images
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
    params.require(:product).permit(:title, :description, :price, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
  
end
