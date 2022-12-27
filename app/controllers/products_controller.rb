class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: 'Producto agregado con éxito'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])    
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      redirect_to root_path, notice: "Producto actualizado con éxito"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy!
      redirect_to root_path, alert: "Producto eliminado con éxito"
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
  
end
