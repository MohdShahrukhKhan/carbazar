
class Offer < ApplicationRecord
  belongs_to :car
  belongs_to :variant
  # Assuming you have a Feature model, you can include this line if necessary
  belongs_to :feature

 


  def discounted_price
    return nil if discount.nil? || variant.nil? || variant.price.nil?

    original_price = variant.price.to_f # Ensure the price is a float for calculations
    discount_amount = (original_price * discount) / 100 # Calculate the discount amount
    original_price - discount_amount # Calculate the final price after discount
  end
end