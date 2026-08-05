
class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 3 }
  validates :sku, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end