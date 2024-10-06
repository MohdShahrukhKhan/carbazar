# app/serializers/offer_serializer.rb
class OfferSerializer < ActiveModel::Serializer
  attributes :id, :offer_name, :discount, :start_date, :end_date

attribute :variant_name do |object|
  # object.object.variant.present? ? object.object.variant.variant : nil
  object.object.variant.variant
end







end
