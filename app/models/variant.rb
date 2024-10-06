# # class Variant < ApplicationRecord
# # 	belongs_to :car
# #   has_many :offers
# #   has_many :wishlists
# #   has_many :bookings
# #   has_one :feature
# #   has_many :review
# #   has_many :order_items

# # 	ransack_alias :car_id_eq, :car


# #   validates :variant, presence: true, uniqueness: true


# #   def self.ransackable_attributes(auth_object = nil)
# #     super + ['car_id']
# #   end

# #     def decrease_quantity
# #     self.quantity -= 1 if self.quantity > 0
# #     save
# #   end

# #   def discounted_price
# #   active_offer = offers.where('start_date <= ? AND end_date >= ?', Date.today,Date.today).first
# #   if active_offer
# #     discount_amount = (price.to_f*active_offer.discount / 100)
# #     price.to_f - discount_amount 
# #     else
# #       price.to_f
# #   end
# #   end

# # end



# class Variant < ApplicationRecord
#   belongs_to :car
#   has_many :offers
#   has_many :wishlists
#   has_many :bookings
#   has_one :feature
#   has_many :reviews # Changed from `:review` to `:reviews`
#   has_many :order_items

#   accepts_nested_attributes_for :features, allow_destroy: true


#   ransack_alias :car_id_eq, :car

#   validates :variant, presence: true, uniqueness: true

#   def self.ransackable_attributes(auth_object = nil)
#     super + ['car_id']
#   end

#   def decrease_quantity
#     self.quantity -= 1 if self.quantity > 0
#     save
#   end

#   def discounted_price
#     active_offer = offers.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).first
#     if active_offer
#       discount_amount = (price.to_f * active_offer.discount / 100)
#       price.to_f - discount_amount
#     else
#       price.to_f
#     end
#   end
# end


class Variant < ApplicationRecord
  belongs_to :car
  has_many :offers
  has_many :wishlists
  has_many :bookings
  has_one :feature # This indicates a one-to-one relationship
  has_many :reviews
  has_many :order_items
  
  accepts_nested_attributes_for :feature, allow_destroy: true # Change this line to use `feature`

  ransack_alias :car_id_eq, :car

  validates :variant, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    super + ['car_id']
  end

  def decrease_quantity
    self.quantity -= 1 if self.quantity > 0
    save
  end

  def discounted_price
    active_offer = offers.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).first
    if active_offer
      discount_amount = (price.to_f * active_offer.discount / 100)
      price.to_f - discount_amount
    else
      price.to_f
    end
  end
end