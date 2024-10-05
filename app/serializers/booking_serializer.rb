# app/serializers/booking_serializer.rb
class BookingSerializer < ActiveModel::Serializer
  attributes :id, :status, :booking_date, :offer_name
  belongs_to :user

  attribute :user_name do |object|
    object.object.user.name
  end  

  attribute :variant_name do |object|
  object.object.variant.variant
end
attribute :variant_price do |object|
  object.object.variant.price
end

attribute :car_name do |object|
  object.object.car.name
end

  attribute :offer_name do |object|
    # Accessing the first offer's name directly from the associated variant
    offer = object.object.variant.offers.last
    offer.present? ? offer.offer_name : 'No offer available'
  end


end
