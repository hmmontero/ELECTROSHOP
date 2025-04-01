class CartProductsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @cart_product = CartProduct.new
    @cart_product.quantity = 1
    @cart_product.product = @product
    @cart_product.cart = current_user.cart
    @cart_product.save
  end

  # def update
  #   @cart_product = @cart.cart_products.find(params[:id])

  #   if @cart_product
  #     cart_product.update(quantity: cart_product.quantity + 1)
  #   elsif
  #     cart_product.update(quantity: cart_product.quantity - 1)
  #   else
  #     render :@cart
  #   end

  # end

  def destroy
    @cart_products = @cart.cart_products.find(params[:id])
    @cart_product.destroy
  end

  def increment
    @cart_product = CartProduct.find(params[:id])
    @cart_product.quantity += 1
    @cart_product.save
    redirect_to cart_path(@cart_product.cart)
  end

  # def decrement
  #   @cart_product = CartProduct.find(params[:id])
  #   @cart_product.quantity -= 1
  #   @cart_product.save
  # end
end
