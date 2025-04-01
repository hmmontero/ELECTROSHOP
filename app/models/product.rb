class Product < ApplicationRecord
  belongs_to :user
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products

  validates :name, :price, :description, presence: true
end
