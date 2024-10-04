# app/serializers/offer_serializer.rb
class OfferSerializer < ActiveModel::Serializer
  attributes :id, :offer_name, :discount, :start_date, :end_date, :discounted_price

attribute :variant_name do |object|
  object.object.variant.variant
end

attribute :name do |object|
  object.object.car.name
end




end
