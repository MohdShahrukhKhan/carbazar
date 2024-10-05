class Variant < ApplicationRecord
	belongs_to :car
  has_many :offers
  has_many :wishlists
  has_many :bookings
  has_many :features
  has_many :review

	ransack_alias :car_id_eq, :car


  validates :variant, presence: true, uniqueness: true


  def self.ransackable_attributes(auth_object = nil)
    super + ['car_id']
  end
end

