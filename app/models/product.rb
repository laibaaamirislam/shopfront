
class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 3 }
  validates :sku, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  scope :search, ->(query) {
    where("name LIKE :q OR description LIKE :q", q: "%#{sanitize_sql_like(query)}%") if query.present?
  }

  scope :in_category, ->(category_id) {
    where(category_id: category_id) if category_id.present?
  }
end