class PaymentsController < ApplicationController
  def show
    @cart_products = CartProduct.find(params[:id])
    # @cart = Cart.find(params[:id])
  end
end
