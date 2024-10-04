# app/serializers/booking_serializer.rb
class BookingSerializer < ActiveModel::Serializer
  attributes :id, :status, :booking_date
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
end
