
class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  STATUSES = %w[paid shipped delivered cancelled].freeze
  validates :status, inclusion: { in: STATUSES }
end