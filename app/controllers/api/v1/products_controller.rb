class Api::V1::ProductsController < ApplicationController

  def index
    products=Product.all
    render json: products, status: 200
  end

  def show
    product=Product.find_by(id: params[:id])
    if product
      render json: product, status: 200
    else
      render json: {error: "Product not Found"}
    end
  end

  def create
    product=Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price],
      description: prod_params[:description]
    )
    if product.save
      render json: product, status: 201
    else
      render json: {error: "Error creating object"}
    end
  end

  def destroy
    product=Product.find_by(id: params[:id])
    if product.destroy
      render json: product, status: 204
    else
      render json: {error: "Error deleting object"}
    end
  end

  def update
    product=Product.find_by(id: params[:id])
    if product.update(prod_params)
      render json: product, status: 201
    else
      render json: {error: "Error actualizando objecto"}
    end
  end

  private
    def prod_params
      params.require(:product).permit(
        [
          :name,
          :brand,
          :price,
          :description
        ]
      )
    end
end
