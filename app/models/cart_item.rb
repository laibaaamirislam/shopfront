
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  validate :quantity_within_stock_limit

  private

  def quantity_within_stock_limit
    return unless quantity && product

    if quantity > product.stock_quantity
      errors.add(:quantity, "cannot exceed available stock (#{product.stock_quantity})")
    end
  end
end