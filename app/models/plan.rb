

# class Plan < ApplicationRecord

#   has_many :subscriptions

#   enum plan_type: { free: 0, paid: 1 }

#   validates :price_monthly, :price_yearly, presence: true, if: :paid_plan?
#   validates :discount, :discount_type, :discount_percentage, presence: true, if: :paid_plan?
#   validates :name, presence: true

#   def self.ransackable_attributes(auth_object = nil)
#     super + [
#       'stripe_price_id', 'name',  'price_monthly', 
#       'price_yearly', 'discount', 'discount_type', 
#       'discount_percentage', 'active', 'available', 'details', 'plan_type', 'months', 'limit_type','limit', 'benefits', 'coming_soon'
#     ]
#   end


#   def paid_plan?
#     plan_type == 'paid'
#   end

#   def discounted_price_yearly
#   return price_yearly unless discount.present? && discount_percentage.present?
#   if discount_type == 'Percentage'
#     (price_yearly - (price_yearly * discount_percentage / 100.0)).round(2)
#   elsif discount_type == 'Fixed'
#     (price_yearly - discount_percentage.to_f).round(2)
#   else
#     price_yearly
#   end
# end



#   def discounted_price_yearly
#     return price_yearly unless discount.present? && discount_percentage.present?

#     Rails.logger.debug "Calculating Discounted Price Yearly..."
#     Rails.logger.debug "Original Yearly Price: #{price_yearly}, Discount Type: #{discount_type}, Discount Percentage: #{discount_percentage}"

#     case discount_type
#     when "Percentage"
#       discounted_price = price_yearly - (price_yearly * (discount_percentage.to_f / 100))
#       Rails.logger.debug "Discounted Yearly Price (Percentage): #{discounted_price}"
#       discounted_price
#     when "Fixed"
#       discounted_price = price_yearly - discount_percentage.to_f
#       Rails.logger.debug "Discounted Yearly Price (Fixed): #{discounted_price}"
#       discounted_price
#     else
#       Rails.logger.warn "Unknown discount type: #{discount_type}. Returning original price."
#       price_yearly
#     end
#   end
# end



class Plan < ApplicationRecord
  has_many :subscriptions

  enum plan_type: { free: 0, paid: 1 }

  validates :price_monthly, :price_yearly, presence: true, if: :paid_plan?
  validates :discount, :discount_type, :discount_percentage, presence: true, if: :paid_plan?
  validates :name, presence: true


  def self.ransackable_attributes(auth_object = nil)
    super + [
      'stripe_price_id', 'name', 'price_monthly', 
      'price_yearly', 'discount', 'discount_type', 
      'discount_percentage', 'active', 'available', 
      'details', 'plan_type', 'months', 'limit_type', 
      'limit', 'benefits', 'coming_soon', 
      'subscriptions_id', # Allow searching by subscription ID
      'subscriptions.user_id' # Add more fields as needed
    ]
  end


  def paid_plan?
    plan_type == 'paid'
  end

  def discounted_price_monthly
    return price_monthly unless discount.present? && discount_percentage.present?

    Rails.logger.debug "Calculating Discounted Price Monthly..."
    Rails.logger.debug "Original Monthly Price: #{price_monthly}, Discount Type: #{discount_type}, Discount Percentage: #{discount_percentage}"

    case discount_type
    when "Percentage"
      discounted_price = price_monthly - (price_monthly * (discount_percentage.to_f / 100))
      Rails.logger.debug "Discounted Monthly Price (Percentage): #{discounted_price}"
      discounted_price
    when "Fixed"
      discounted_price = price_monthly - discount_percentage.to_f
      Rails.logger.debug "Discounted Monthly Price (Fixed): #{discounted_price}"
      discounted_price
    else
      Rails.logger.warn "Unknown discount type: #{discount_type}. Returning original price."
      price_monthly
    end
  end

  def discounted_price_yearly
    return price_yearly unless discount.present? && discount_percentage.present?

    Rails.logger.debug "Calculating Discounted Price Yearly..."
    Rails.logger.debug "Original Yearly Price: #{price_yearly}, Discount Type: #{discount_type}, Discount Percentage: #{discount_percentage}"

    case discount_type
    when "Percentage"
      discounted_price = price_yearly - (price_yearly * (discount_percentage.to_f / 100))
      Rails.logger.debug "Discounted Yearly Price (Percentage): #{discounted_price}"
      discounted_price
    when "Fixed"
      discounted_price = price_yearly - discount_percentage.to_f
      Rails.logger.debug "Discounted Yearly Price (Fixed): #{discounted_price}"
      discounted_price
    else
      Rails.logger.warn "Unknown discount type: #{discount_type}. Returning original price."
      price_yearly
    end
  end
end









