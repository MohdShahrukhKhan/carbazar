# app/serializers/plan_serializer.rb
class PlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :price, :details, :plan_type, :months,
             :price_monthly, :price_yearly, :limit, :limit_type, :discount,
             :discount_type, :discount_percentage, :benefits, :coming_soon,
             :active, :available, :discounted_price_monthly, :discounted_price_yearly

  # Custom methods for discounted prices
  def discounted_price_monthly
    object.discounted_price_monthly
  end

  def discounted_price_yearly
    object.discounted_price_yearly
  end
end
