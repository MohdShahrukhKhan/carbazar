class Brand < ApplicationRecord
  has_many :cars

  validates :name, presence: true, uniqueness: true

  # Assuming popularity is based on the total number of orders across all variants under this brand
  scope :popular, -> {
    joins(cars: :order_items).group(:id).order('COUNT(order_items.id) DESC')
  }
end
