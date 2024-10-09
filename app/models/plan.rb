# class Plan < ApplicationRecord

#   #has_many :subscriptions

#   enum plan_type: { free: 0, paid: 1 }
#   validates :price_monthly, :price_yearly, presence: true, if: :paid_plan?
#   validates :discount, :discount_type, :discount_percentage, presence: true, if: :paid_plan?
#   validates :duration, presence: true
#   validates :name, presence: true
#   validates :plan_type, presence: true

#    #has_many :subscriptions
#   #  ransack_alias :subscription_id_eq, :subscription_id

#   #  def self.ransackable_attributes(auth_object = nil)
#   #   super + ['subscription']
#   # end
#  # def self.ransackable_attributes(auth_object = nil)
#  #    super + ['stripe_price_id']  # Include stripe_price_id here
#  #  end
#  def self.ransackable_attributes(auth_object = nil)
#   super + ['stripe_price_id', 'name', 'duration', 'price_monthly', 
#            'price_yearly', 'discount', 'discount_type', 
#            'discount_percentage', 'active', 'available', 'details']
# end



#   # Custom method to check if the plan is paid
#   def paid_plan?
#     plan_type == 'paid'
#   end

#   # Method to calculate discounted monthly price
#   def discounted_price_monthly
#     return price_monthly unless discount.present? && discount_percentage.present?

#     Rails.logger.debug "Calculating Discounted Price Monthly..."
#     Rails.logger.debug "Original Monthly Price: #{price_monthly}, Discount Type: #{discount_type}, Discount Percentage: #{discount_percentage}"

#     if discount_type == "Percentage"
#       discounted_price = price_monthly - (price_monthly * (discount_percentage.to_f / 100))
#       Rails.logger.debug "Discounted Monthly Price (Percentage): #{discounted_price}"
#       discounted_price
#     elsif discount_type == "Fixed"
#       discounted_price = price_monthly - discount_percentage.to_f
#       Rails.logger.debug "Discounted Monthly Price (Fixed): #{discounted_price}"
#       discounted_price
#     else
#       price_monthly
#     end
#   end

#   # Method to calculate discounted yearly price
#   def discounted_price_yearly
#     return price_yearly unless discount.present? && discount_percentage.present?

#     Rails.logger.debug "Calculating Discounted Price Yearly..."
#     Rails.logger.debug "Original Yearly Price: #{price_yearly}, Discount Type: #{discount_type}, Discount Percentage: #{discount_percentage}"

#     if discount_type == "Percentage"
#       discounted_price = price_yearly - (price_yearly * (discount_percentage.to_f / 100))
#       Rails.logger.debug "Discounted Yearly Price (Percentage): #{discounted_price}"
#       discounted_price
#     elsif discount_type == "Fixed"
#       discounted_price = price_yearly - discount_percentage.to_f
#       Rails.logger.debug "Discounted Yearly Price (Fixed): #{discounted_price}"
#       discounted_price
#     else
#       price_yearly
#     end
#   end


#  def self.ransackable_attributes(auth_object = nil)
#     super + ['name', 'duration', 'price', 'plan_type', 'months', 
#              'price_monthly', 'price_yearly', 'limit', 'limit_type', 
#              'discount', 'discount_type', 'discount_percentage', 
#              'benefits', 'coming_soon', 'active', 'available', 'details']
#   end
  
# end

class Plan < ApplicationRecord

  has_many :subscriptions

  enum plan_type: { free: 0, paid: 1 }

  validates :price_monthly, :price_yearly, presence: true, if: :paid_plan?
  validates :discount, :discount_type, :discount_percentage, presence: true, if: :paid_plan?
  #validates :duration, :name, :plan_type, presence: true

  def self.ransackable_attributes(auth_object = nil)
    super + [
      'stripe_price_id', 'name',  'price_monthly', 
      'price_yearly', 'discount', 'discount_type', 
      'discount_percentage', 'active', 'available', 'details', 'plan_type', 'months', 'limit_type','limit', 'benefits', 'coming_soon'
    ]
  end

  #   ransack_alias :subscription_id_eq, :subscriptions_id

  # def self.ransackable_attributes(auth_object = nil)
  #   super + ['subscription_id'] # Add other attributes you want to query on
  # end

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








