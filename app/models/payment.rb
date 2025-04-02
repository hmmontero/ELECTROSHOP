class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
