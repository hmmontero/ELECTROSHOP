class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :create_cart

  has_many :products, dependent: :destroy
  has_one :cart

  # validates :name, :address, :phone_number, :birth_date, presence: true
  validates :email, presence: true, uniqueness: true

  private

  def create_cart
    create_cart! unless cart.present?
  end
end
