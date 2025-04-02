class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  def total_amount
    cart_products.sum do |product|
      product.price * product.quantity
    end
  end
end
