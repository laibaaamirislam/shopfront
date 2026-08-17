
class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end
