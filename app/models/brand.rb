class Brand < ApplicationRecord
  has_many :cars
  validates :name, presence: true

  

  has_many :dealers

  # def self.ransackable_attributes(auth_object = nil)
  #   ["created_at", "id", "name", "updated_at"]
  # end
  # def self.ransackable_associations(auth_object = nil)
  #   ["new_cars", "upcoming_cars"]
  # end
end
