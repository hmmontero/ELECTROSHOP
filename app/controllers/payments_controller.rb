class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
  end

  def create
    @cart = Cart.find(params[:cart_id])
    @total_amount = @cart.total_amount
    @payment = Payment.new(user: current_user, cart: @cart, total_amount: @total_amount)
    if @payment.save
      redirect_to cart_payment_path(@cart, @payment)
    else
      render "carts/show", status: :unprocessable_entity
    end
  end
end
