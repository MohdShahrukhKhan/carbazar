
class Offer < ApplicationRecord

  belongs_to :variant
 


 


  def discounted_price
    return nil if discount.nil? || variant.nil? || variant.price.nil?

    original_price = variant.price.to_f # Ensure the price is a float for calculations
    discount_amount = (original_price * discount) / 100 # Calculate the discount amount
    original_price - discount_amount # Calculate the final price after discount
  end
end