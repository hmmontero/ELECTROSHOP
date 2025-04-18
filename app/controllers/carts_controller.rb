class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find(params[:id])
    @cart_products = @cart.cart_products.order(:created_at)
    @cart = current_user.cart
    @cart_products = @cart.cart_products.includes(:product)
    @total_price = @cart_products.sum { |cp| cp.product.price * cp.quantity }
  end

  def update
    @cart_products = @cart.cart_products.find(params[:id])
    if @cart_products.update(cart_product_params)
      redirect_to @cart, notice: "Updated!"
    else
      redirect_to @cart
    end
  end

  def destroy
    @cart_product = @cart.cart_products.find(params[:id])
    @cart_product.destroy
  end

  private

  def cart_product_params
    params.require(:cart_product)
  end
end
